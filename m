From: johannes.reif@jmg-reif.de (Johannes Reif)
Date: Tue, 02 Oct 2012 22:04:12 +0200
Subject: problem with kernel build
Message-ID: <506B48BC.6060602@jmg-reif.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I'm trying to compile a kernel for a Samsung Galaxy S2 but it fails 
with:

arm-eabi-gcc -Wp,-MD,arch/arm/kernel/.asm-offsets.s.d  -nostdinc 
-isystem 
/root/src/android/kernel/test/linaro-12-android-toolchain/bin/../lib/gcc/arm-eabi/4.7.2/include 
-I/root/src/android/kernel/test/arch/arm/include 
-Iarch/arm/include/generated -Iinclude  -include 
include/generated/autoconf.h -D__KERNEL__ -mlittle-endian 
-Iarch/arm/mach-versatile/include -Iarch/arm/plat-versatile/include 
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -Werror-implicit-function-declaration -Wno-format-security 
-fno-delete-null-pointer-checks -march=armv7-a -mtune=cortex-a9 
-fmodulo-sched -fmodulo-sched-allow-regmoves -O2 -pipe -marm 
-fno-dwarf2-cfi-asm -fstack-protector -mabi=apcs-gnu 
-mno-thumb-interwork -D__LINUX_ARM_ARCH__=5 -march=armv5te 
-mtune=arm9tdmi -msoft-float -Uarm -Wframe-larger-than=1024 
-Wno-unused-but-set-variable -Wno-uninitialized -Wno-unused-function 
-Wno-unused-variable -Wno-unused-value -Wno-unused-label 
-fomit-frame-pointer -Wdeclaration-after-statement -Wno-pointer-sign 
-fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO 
-D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(asm_offsets)" 
-D"KBUILD_MODNAME=KBUILD_STR(asm_offsets)" -fverbose-asm -S -o 
arch/arm/kernel/asm-offsets.s arch/arm/kernel/asm-offsets.c
In file included from include/linux/topology.h:35:0,
                  from include/linux/sched.h:78,
                  from arch/arm/kernel/asm-offsets.c:13:
/root/src/android/kernel/test/arch/arm/include/asm/topology.h: In 
function 'topology_register_notifier':
/root/src/android/kernel/test/arch/arm/include/asm/topology.h:41:53: 
warning: no return statement in function returning non-void [-Wreturn-type]
/root/src/android/kernel/test/arch/arm/include/asm/topology.h: In 
function 'topology_unregister_notifier':
/root/src/android/kernel/test/arch/arm/include/asm/topology.h:42:55: 
warning: no return statement in function returning non-void [-Wreturn-type]
In file included from arch/arm/kernel/asm-offsets.c:16:0:
/root/src/android/kernel/test/arch/arm/include/asm/cacheflush.h: At top 
level:
/root/src/android/kernel/test/arch/arm/include/asm/cacheflush.h:19:22: 
fatal error: mach/smc.h: No such file or directory
compilation terminated.
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

I know that the include path is missing but how it's intended to add the 
according arch/arm/mach-exynos/include directory?
