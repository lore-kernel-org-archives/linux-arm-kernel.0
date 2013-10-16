From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 16 Oct 2013 10:43:54 -0400 (EDT)
Subject: [PATCH v2] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D8817DAE2B4@P3PWEX4MB008.ex4.secureserver.net>
Message-ID: <Pine.LNX.4.44L0.1310161040490.1264-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Oct 2013, Hartley Sweeten wrote:

> On Tuesday, October 15, 2013 5:57 PM, Ryan Mallon wrote:

> > Gah, defconfig changes are a pest. I assume the other removed options
> > are implicitly selected, and their removal is the result of
> > re-minimising the defconfig? Can you put a note about this is the
> > changelog please.
> 
> Yah... It's a mess.
> 
> All I did was:
> make ARCH=arm ep93xx_defconfig
> make ARCH=arm menuconfig		# enable USB_OHCI_HCD_PLATFORM
> make ARCH=arm savedefconfig
> mv defconfig arch/arm/configs/ep93xx_defconfig
> 
> Looks like the last time the ep93xx_defconfig was refreshed was:
> 
> commit 07a8c03f3e06129e847acd068b8b89c13357ee64
> Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Date:   Thu Jun 10 07:12:18 2010 +0200
> 
>     ARM: reduce defconfigs
> 
> Hence the ugly changes.

It's awfully hard to believe that enabling USB_OHCI_HCD_PLATFORM is 
responsible for all those other changes.

Maybe this should be done in two stages.  First create a patch that
describes the differences resulting from:

make ARCH=arm ep93xx_defconfig
make ARCH=arm savedefconfig
mv defconfig arch/arm/configs/ep93xx_defconfig

Then do this patch on top of that one.

Alan Stern
