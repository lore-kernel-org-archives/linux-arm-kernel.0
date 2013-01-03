From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 03 Jan 2013 16:55 +0100
Subject: Early kernel hang with big DTB appended
Message-ID: <7811936.npteFbuYu2@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm observing strange behavior when booting 3.8-rc1 and -rc2 with appended 
DTB. The kernel hangs very early when the DTB is bigger than some 
threshold somewhere around 24 KiB. With fullest possible low level UART 
debugging (and printk patched to use printascii) I'm receiving following 
output:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0xa00
Linux version 3.8.0-rc1-00073-gdf6efca-dirty (t.figa at amdc1227) (gcc 
version 4.5.2 (Gentoo 4.5.2 p1.2, pie-0.4.5) ) #2 SMP PREEMPT Thu Jan 3 
15:37:35 CET 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache

I tested on two Exynos-based boards (exynos4210-trats and one internal 
exynos4412-based board) and same happens on both.

Do you have any ideas?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
