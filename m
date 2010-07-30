From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Fri, 30 Jul 2010 14:47:02 +0000 (UTC)
Subject: Some benchmarks on ARM
Message-ID: <loom.20100730T164158-429@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 06:54:13PM +0200, Robert Schwebel wrote:
> Thanks to everyone who posted feedback!
> 
> An updated version of the article is now here:
> http://www.pengutronix.de/development/kernel/arm-benchmarks-20100729_en.html

Thank you for the interesting analysis. I have conducted your tests on S5PC110
(HummingBird). Cannot tell what the memory type is. Tests fall in line with
BeagleBoard results including clock scaling into account except for test 3
(context switch) which is three times as fast for 60% clock advantage.
There are also minor differences in memory related tests (bandwidth and fork).
All these appears to be conducted by memory subsystem.

LMBench was compiled with instruction:
make CC="arm-linux-gnueabi-gcc -O2 -march=armv7-a -mtune=cortex-a8
-mfloat-abi=softfp -mfpu=neon"
GCC was vanilla-4.4.1 compiler.

LMBench version: 3.0-a9

Environment:
Debian:~/lmbench/bin/i686-pc-linux-gnu# uname -a
Linux Debian 2.6.34-rc6 #2 PREEMPT Fri Jul 30 15:31:57 CEST 2010 armv7l GNU/Linux
Debian:~/lmbench/bin/i686-pc-linux-gnu# cat /proc/cpuinfo

Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 797.90
Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc08
CPU revision    : 2

----------------------------------------------
Test 1
Debian:~/lmbench/bin/# lat_ops -W 100 -N 100
Result: 12.52
Comments: The latency of a single instruction is closely related to a depth of
CPU's pipeline and as such is not a reliable indicator of usable performance.
The mean performance of IPC is in closer relation with processor's speed.

----------------------------------------------
Test 2
Result: 340.92

----------------------------------------------
Test 3
Result: 11.24

----------------------------------------------
Test 4
Result: 6.8816

----------------------------------------------
Test 5
Result: 780.1429

Best regards,
Tomasz Stanislawski
Samsung Poland R&D Center
