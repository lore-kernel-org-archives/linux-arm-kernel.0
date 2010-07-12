From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 16:50:51 -0400 (EDT)
Subject: ARM defconfig files
In-Reply-To: <201007122231.16283.arnd@arndb.de>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<201007122231.16283.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1007121638530.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Arnd Bergmann wrote:

> On Monday 12 July 2010 20:50:29 Uwe Kleine-K?nig wrote:
> > 
> > [1] The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
> > 
> >   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
> > 
> > are available in the git repository at:
> >   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/defconfig/reduced-v2.6.35-rc1
> 
> BTW, looking at the most common entries in there, I think we might at some
> point want to change some of the defaults in the respective Kconfig files.
> Right now an empty defconfig would result in a configuration without
> file system, networking or modules:

We need to come up with a scheme that allows for expressing the most 
likely options you might want if you have machine x and/or machine y 
selected.  Those likely options are for drivers corresponding to 
hardware soldered on the board or integrated into a SOC and therefore 
which is not "optional".  Right now this information is carried in the 
defconfig files.  Without that you need to lookup various datasheets and 
wade through thousands of Kconfig options.  Compared to that, stuff like 
filesystems and networking protocols are optional items that currently 
are more arbitrarily included into or excluded from the defconfig files.  

I think that the first category of options should automatically be 
selected on a per machine basis depending on BASE_CONFIG or the like and 
expressed directly in the Kconfig files.  Typically there are very few 
of those (like a dozen or so for some example target I looked at).


Nicolas
