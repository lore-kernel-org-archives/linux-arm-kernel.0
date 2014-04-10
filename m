From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Apr 2014 11:36:53 +0200
Subject: [PATCH 3/4] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <53465A4B.4040906@free-electrons.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <CABuKBeKnEw38sQYwrkheoWetZZcPTJhKRsBK4a62FS6-6dRFTA@mail.gmail.com>
 <53465A4B.4040906@free-electrons.com>
Message-ID: <8724412.Xp2CkgARik@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 April 2014 08:46:03 Gregory CLEMENT wrote:
> >>
> >> Is it really a fixed clock without any parent, or do you
> >> declare it as a fixed clock because you don't have any clock
> >> common framework support yet?
> > 
> > I don't have any common clock framework support yet.
> 
> So maybe you should provide one (even a very simple one).
> 
> Pretending a clock is a fixed clock and ignoring its parents
> will be problematic when you will add the common clock framework
> support because the device tree is supposed to be stable and you won't
> be able to change it then.

But is this actually a problem here? The current device tree file
will keep working even if the proper driver is there, you just need
to update both the driver and the dts file in order to actually
use the clocks at run-time.

I guess it comes down to the question of whether we want to handle
old kernels with new device trees again, which would be broken here.

	Arnd
