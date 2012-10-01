From: ajellisuk@yahoo.co.uk (Ellis Andrew)
Date: Mon, 1 Oct 2012 17:39:02 +0100 (BST)
Subject: redirecting console output to display
Message-ID: <1349109542.85942.YahooMailNeo@web133201.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Further to a previous post (http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/121647.html) I have managed to get all post output to appear on a display whilst my system is booting. As the system boots I can see the Linux penguin, and the verbose output from the kernel as it boots appearing on the screen.

The kernel shows a message "disabling irom" and then the screen is disabled.

How can I set up my kernel so that it enables the display and outputs a console on tty0?

My system has an MCS8144 processor, and I'm using Linux 2.6.24 (which was supplied as part of the BSP). I have contacted Moschip many times about this problem, but they just don't answer.

My boot arguments are root=/dev/mtdblock3 rootfstype=jffs2 rw console=ttyMCS console=tty0 CONSOLE=tty0 mem=64M at 0x0 panic=4 MCS8142VGA=792

There is an fb device node: /dev/fb0


I have configure the kernel with the following options chosen:

Device drivers-->Character devices->Virtual terminal
Device drivers-->Character devices-> Support for binding and unbinding console drivers
Device drivers--> Graphics support--> Support for frame buffer devices -->Enable firmware EDID 
Device drivers--> Graphics support--> Support for frame buffer devices -->Enable Video Mode Handling Helpers
Device drivers--> Graphics support--> Support for frame buffer devices -->MCS8142 FramBuffer Driver
Device drivers--> Graphics support--> Console display driver support-->Framebuffer Console support
Device drivers--> Graphics support--> Console display driver support-->Map the console to the primary display device 
Device drivers--> Graphics support--> Console display driver support-->Select compiled-in fonts

Cansomeone please suggest what I need to do to enable the frame buffer driver and display from within the kernel and direct the console to output to tty0



Kind regards

Andrew
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121001/a94446bc/attachment.html>
