From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 13 Feb 2012 10:58:24 -0800
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
In-Reply-To: <20120213181410.GE1426@atomide.com>
References: <1329151422-2146-1-git-send-email-mporter@ti.com>
 <20120213165209.GA31482@n2100.arm.linux.org.uk>
 <20120213165617.GE3494@opensource.wolfsonmicro.com>
 <20120213175233.GC1426@atomide.com>
 <20120213180236.GB31482@n2100.arm.linux.org.uk>
 <20120213181410.GE1426@atomide.com>
Message-ID: <20120213185823.GF3494@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 10:14:10AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120213 09:31]:
> > On Mon, Feb 13, 2012 at 09:52:34AM -0800, Tony Lindgren wrote:

> > > Can't we just leave out the .id and have it automatically assigned?

It'd be nice but...

> > Unfortunately, there's no such infrastructure in the driver model.

> Hmm OK, -1 seems to be just used for name in platform_device_add().

-1 is a valid ID also, it means "there's only one of these things so
don't display a number".  Which is sad but there we are.  I'm at ELC/ABS
so I might try and find Greg in person here to see if we can come up
with something better, it seems like this is something the core ought to
be able to help with in much the same way that the USB stuff can.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/6b485802/attachment.sig>
