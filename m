From: sposelenov@emcraft.com (Sergei Poselenov)
Date: Sat, 28 May 2011 14:59:25 +0400
Subject: clone() for 2.6.33 Cortex-M3 kernel?
Message-ID: <1306580365.749.1.camel@mehome>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I'm trying to implement the pthread support for a Cortex-M3
Thumb target using the CodeSourcery uclibc toolchain.

I faced the following problem: a simple clone() test program
crashes the system. As I found, the problem is that the 
stack for the new clone process, which is passed to the clone()
syscall, returns incorrectly for the new process (32 bytes higher)
and the pointer to the clone function and argument, which are saved
in the new clone stack, clobbered.

Is it a known issue?

In the kernel configuration, the CONFIG_CPU_V7M and CONFIG_ARM_THUMB
are enabled.



Thanks for any help.

Regards,
Sergei
