From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Fri, 11 Mar 2011 19:58:16 +0200
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <20110311155257.GA6711@kroah.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299846911-15782-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103111532.52393.arnd@arndb.de>
	<20110311155257.GA6711@kroah.com>
Message-ID: <20110311175816.GC7291@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Mar 11, 2011 at 07:52:57AM -0800, ext Greg KH wrote:
> On Fri, Mar 11, 2011 at 03:32:51PM +0100, Arnd Bergmann wrote:
> > On Friday 11 March 2011, Maxime Coquelin wrote:
> > > Common base to export System-on-Chip related informations through sysfs.
> > > 
> > > Creation of a "socinfo" directory under /sys/.
> > > Creation of SoC information entries.
> > > 
> > > Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>
> > 
> > I think it's better than the previous patch to create an
> > artificial device in /sys/devices/system/socinfo, but I'd
> > still prefer the information to be attached to a real device
> > that represents the SOC, as I explained in the discussion with
> > Linus Walleij.
> > 
> > You should definitely add Greg on Cc, as he's maintaining sysfs
> > and certainly has an opininion here.
> > 
> > 	Arnd
> > 
> > > ---
> > >  Documentation/ABI/testing/sysfs-socinfo |   16 ++++++
> > >  drivers/base/Kconfig                    |    3 +
> > >  drivers/base/Makefile                   |    1 +
> > >  drivers/base/soc.c                      |   79 +++++++++++++++++++++++++++++++
> > >  include/linux/sys_soc.h                 |   50 +++++++++++++++++++
> > >  5 files changed, 149 insertions(+), 0 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-socinfo
> > >  create mode 100644 drivers/base/soc.c
> > >  create mode 100644 include/linux/sys_soc.h
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-socinfo b/Documentation/ABI/testing/sysfs-socinfo
> > > new file mode 100644
> > > index 0000000..afd9da2
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-socinfo
> > > @@ -0,0 +1,16 @@
> > > +What:		/sys/socinfo
> > > +Date:		March 2011
> > > +contact:	Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
> > > +Description:
> > > +		The /sys/socinfo directory contains information about the
> > > +		System-on-Chip.	It is only available if platform implements it.
> > > +		This directory contains two kind of attributes :
> > > +			- common attributes: 
> > > +				* machine: the name of the machine.
> > > +				* family: the family name of the SoC
> > > +			- SoC-specific attributes: The SoC vendor can declare attributes
> > > +			  to export some strings to user-space, like the serial-number for
> > > +			  example.
> > > +
> > > +Users:
> > > +		User-space applications which needs these kind of attributes.
> 
> I thought I rejected this the last time it came around?
> 

Greg,

Do you mind sharing the link of the thread where you have reject this?

> I still fail to understand why this is needed, please provide more
> information about why you feel this is something that the kernel needs.

In case of OMAP, there are few ids that we would expose to user space,
like serial, revision and die id to quote some from top of my mind.
I must emphasize  that these are not data from CPU at all, they belong
to SoC itself.

This info can be useful to track buggy silicon misbehaving on products
which are already on the market. For instance, one possible usage would
be to collect from products which arrives on customer care centers.

That's obviously the view I have from OMAP perspective.

But looks like if we had some common way to expose this data, not only
OMAP socs would benefit of it, as you can see interest from other soc vendors
in this thread (also on V1 of this patch set or on my original patch set over /proc)


> 
> thanks,
> 
> greg k-h

-- 
Eduardo Valentin
