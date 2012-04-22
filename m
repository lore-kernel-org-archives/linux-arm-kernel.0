From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 22 Apr 2012 12:21:22 +0200
Subject: arch/arm/mach-s3c2410/Kconfig is unsourced
Message-ID: <1335090082.1814.27.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) commit 85fd6d63bf2927b9da7ab1b0d46723bfdb13808c ("ARM: S3C2410: move
mach-s3c2410/* into mach-s3c24xx/") orphaned
arch/arm/mach-s3c2410/Kconfig: currently nothing sources that file in
Linus' tree.

1) I haven't looked in depth at this, but this made S3C2410_PLLTABLE
disappear from the build system (ie, arch/arm/mach-s3c2410/pll.c is dead
code now). Moreover, this basically turned both "select S3C2410_CPUFREQ
if CPU_FREQ_S3C24XX", under "config CPU_S3C2410", and "select
S3C2410_IOTIMING if S3C2410_CPUFREQ", under "config ARCH_BAST", into
nops (both in arch/arm/mach-s3c24xx/Kconfig).

2) So to me it seems the move has only been done half: either more
things needs to be moved or those things can be removed entirely. But
perhaps arch/arm/mach-s3c2410/Kconfig should just be sourced again.


Paul Bolle
