From: ilya@compulab.co.il (Ilya Ledvich)
Date: Tue, 16 Feb 2016 09:56:47 +0200
Subject: iMX7d cpu1 issue
Message-ID: <56C2D63F.1030408@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,
I'm working on Compulab CL-SOM-IMX7 device 
(http://www.compulab.co.il/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module) 
based on Freescale iMX7d CPU.
I use the Freescale latest BSP imx_3.14.52_1.1.0_ga  and the Linux 
mainline v4.4-rc6 as a reference.
I observe an issue with bringing up the second CPU core. Briefly, the 
kernel can successfully boot only when CPU1 fails to come online.
In this case the boot log shows the following messages:
...
CPU1: failed to come online
Brought up 1 CPUs
SMP: Total of 1 processors activated (6.00 BogoMIPS).
...

Otherwise, the device tries to start kernel several times until the boot 
process eventually crashes. Please see attached logs for more details.
This never happens on mainline Linus kernel, because it never tries to 
bring up CPU1.
Unfortunately, we cannot verify this behavior on reference board cause 
we have no one.
Have you ever seen such behavior? Could you please advice something?
Kind regards,
Ilya.




-------------- next part --------------
A non-text attachment was scrubbed...
Name: cl-som-imx7-boot-ok.log
Type: text/x-log
Size: 14933 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/fb57af9a/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cl-som-imx7-boot-failed.log
Type: text/x-log
Size: 21571 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/fb57af9a/attachment-0003.bin>
