From: ada@thorsis.com (Alexander Dahl)
Date: Wed, 23 Nov 2016 17:13:05 +0100
Subject: reboot fails on at91sam9g20 with kernel 4.x
Message-ID: <2093786.uQmBVvCouf@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hei hei,

while upgrading a at91sam9g20 based board to a recent kernel I stumbled 
over a problem I can not solve by myself. We have a board which is more 
or less a stripped down version of the at91sam9g20ek. The kernels I was 
trying lately with a custom DT were 3.14.79, 3.18.44 (didn't work), 
4.4.32, 4.8.6 and 4.9-rc6+. The rootfs is built with 
OSELAS.Toolchain-2014.12.2, ptxdist 2016.11.0, gcc 4.9.2, glibc 2.20, 
busybox v1.24.2 and it's on a UBIFS on NAND flash.

The following happens if I try to reboot a 4.x kernel from console:

	The system is going down NOW!
	Sent SIGTERM to all processes
	macb fffc4000.ethernet eth0: link down
	Requesting system reboot
	reboot: Restarting system
	Reboot failed -- System halted

The last message obviously comes from arch/arm/kernel/reboot.c and 
something fails. ;-)

Searching the web I found someone having a similar problem here:

	https://groups.google.com/forum/#!topic/acmesystems/vC_66zmcatk

Reboot works with 3.x kernels (if they run at all). I'll try a 4.1 
tomorrow, but I would be happy if someone could assist me in debugging 
this.

Greets
Alex
