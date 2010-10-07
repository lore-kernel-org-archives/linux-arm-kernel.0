From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 7 Oct 2010 16:23:29 +0200
Subject: linux hang on i.mx35 board, a sdma problem?
Message-ID: <201010071623.54903.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm currently developing on an i.mx35 board (http://www.ic-
board.de/product_info.php?info=p159_ICnova-i-MX353-OEM.html) (I use the 
mx35_pdk config for linux kernel)
and noticed a strange behavior. If I run it while openocd is attached to JTAG 
linux stops/seem to stop during boot after initializing FEC. But if I stop the 
execution and attach gdb I can see it loops inside default_idle. After 
removing the fec driver the same goes until the first few chars printed from 
busybox init (run from initramfs).
If I don't attach openocd to JTAG, the system boots fine, but I cannot attach 
openocd to the running linux system.
I have to admit I removed the DMA device drivers, because otherwise linux 
doesn't seem to start at all.
Is this problem related to the sdma unit? I read something from the manual 
sdma can be blocked from jtag access, maybe this breaks the chain.
If not, what could be the cause, that the system is not starting properly, but 
the idle loop is executed?

Best regards,
Alexander

PS: I tested eariler on the BSP (2.6.34) from in-circuit, but the test above 
is using linux-2.6.36-rc7.
