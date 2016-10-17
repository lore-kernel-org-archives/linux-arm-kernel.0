From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 17 Oct 2016 16:54:21 +0200
Subject: Regression: usb serial gadget on sama5d3 broken
In-Reply-To: <569c65cd-4e2e-4455-c24c-074f8c5fd315@axentia.se>
References: <569c65cd-4e2e-4455-c24c-074f8c5fd315@axentia.se>
Message-ID: <38ca0db7-9bc6-7258-b102-ea9fdeb9b03c@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/10/2016 ? 14:53, Peter Rosin a ?crit :
> Hi!
> 
> I'm suffering from a regression while using the usb gadget port on the
> sama5d3 to get terminal access to the device in question (CONFIG_USB_G_SERIAL).
> 
> I get this message when I try to connect:
> udc: ep: Invalid setup request: 02.01 v0000 i0081 l0, halting endpoint...
> 
> A bisect blames commit v4.7-rc1-21-gc32b5bcfa3c4 "ARM: dts: at91: Fix
> USB endpoint nodes".
> 
> And indeed, reverting that commit on top of v4.9-rc1 fixes things,
> although that doesn't look like the best of fixes...
> 
> BTW, the bisect was extremely painful since v4.7-rc1 seemed broken
> somewhere in the overlayfs area. I hope I will never ever need to bisect
> in the v4.6..v4.7 area again. This was the second time, the first time
> I was chasing a gpio interrupt bug, but I never found out what was wrong
> and stopped looking when v4.9-rc1 turned out to be ok even though v4.8
> was bad, it was just too painful to look for things that already seemed
> fixed.

I guess that you are referring to the regression listed here:
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1239220.html

The patch is available and will hopefully land in an official kernel
soon (4.8.1) as said by Felipe and Greg.

Sorry for the inconvenience. Best regards,
-- 
Nicolas Ferre
