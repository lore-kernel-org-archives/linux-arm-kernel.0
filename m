From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Thu, 22 Apr 2010 16:42:22 +0200
Subject: AT91: how to use additional 128mb RAM on the at91sam9g45ek?
Message-ID: <4BD0604E.7060209@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I use at91sam9g45-ek with the kernel 2.6.33. Following this post http://www.at91.com/forum/viewtopic.php/f,12/t,18589/p,30450/ I configured 256Mb in U-Boot, but when Linux kernel starts it ignores the second area saying:

CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Atmel AT91SAM9G45-EKES
Memory policy: ECC disabled, Data cache writeback
Ignoring RAM at 20000000-27ffffff (vmalloc region overlap).
Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz

The first area 0x70000000-0x77ffffff will be mapped to 0xc0000000
the second area 20000000-27ffffff will be mapped to 0x70000000, that is smaller than 0xc0000000 and thus invalid.

What can I do to use RAM from both banks to get 256Mb of RAM?

Best regards,
Yegor
