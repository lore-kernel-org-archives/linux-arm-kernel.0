From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Wed, 21 Oct 2009 12:43:58 +0200
Subject: [at91sam9g45] fail to start second kernel via kexec if watchdog is
	enabled
Message-ID: <4ADEE5EE.8020205@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have problem booting the second kernel after enabling the watchdog following these steps: http://www.at91.com/index.php?option=com_jfusion&Itemid=57&jfile=viewtopic.php&f=12&t=5551&p=29283&hilit=watchdog+bootstrap#p29283
Bootstrap: don't touch watchdog
U-Boot: configure watchdog and set the timer counter value to 16 seconds
Linux: keep pinging the watchdog

The first kernel (booted from u-boot) is working as expected, but if I start the new one using kexec it gets only till frame buffer init:

....
NetWinder Floating Point Emulator V0.97 (double precision)
Slow work thread pool: Starting up
Slow work thread pool: Ready
JFFS2 version 2.2. (NAND) -? 2001-2006 Red Hat, Inc.
msgmni has been set to 245
io scheduler noop registered
io scheduler anticipatory registered (default)
atmel_lcdfb atmel_lcdfb.0: backlight control is not available
atmel_lcdfb atmel_lcdfb.0: 510KiB frame buffer at 77980000 (mapped at ffa00000)
Start AT91Bootstrap...

Without watchdog there is no problem. Both kernels (2.6.32-rc5) are the same. Any idea?

Best regards,
Yegor
