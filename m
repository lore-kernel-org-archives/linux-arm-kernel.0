From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 May 2014 21:00:47 +0800
Subject: i.MX6 USB OTG support is broken on linux-next
Message-ID: <20140509130046.GP2794@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm running next-20140508 kernel on imx6q-sabresd board with USB
mouse/keyboard connected to OTG port.  It  works well on 3.15-rc but
is broken on recent linux-next kernel with the message like below.

...
usb 1-1: device v413c p2107 is not supported
hub 1-0:1.0: unable to enumerate USB device on port 1

With the help from Peter, I found that the issue shows up only when
CONFIG_USB_OTG_FSM is enabled.  The option is enabled by commit 8fd2f1f
(ARM: imx_v6_v7_defconfig: Enable drivers for i.MX51 USB Host support.)
from IMX tree.

I guess this is a sign that chipidea otg_fsm driver is buggy?  I do not
think dropping CONFIG_USB_OTG_FSM selection from imx_v6_v7_defconfig is
a solution, and we need to fix the issue in usb driver, right?

Shawn
