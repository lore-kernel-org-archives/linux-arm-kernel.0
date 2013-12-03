From: robt201108@gmail.com (robert)
Date: Tue, 03 Dec 2013 22:54:52 +0000
Subject: Kernel 3.13-rc - DreamPlug compile failure - PHYS_OFFSET undeclared
Message-ID: <529E613C.5030902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel 3.12.2 compiles and install/runs OK, but 3.13-rc1 and -rc2 (and
linux-next) compile fails, when configured for DreamPlug..

Steps to reproduce:
# make ......... kirkwood_defconfig
# make xconfig
Select 'General setup' / 'Embedded system'
Deselect 'Patch physical to virtual translations at runtime'
Set value of 'Physical address of main memory' to 0x0
(save config), then:
# make -j4
.....
.....
DTC arch/arm/boot/dts/kirkwood-ts219-6282.dtb
In file included from ~/linux-3.13-rc2/arch/arm/include/asm/page.h:163:0,
from include/linux/mm_types.h:16,
from include/linux/sched.h:24,
from arch/arm/kernel/asm-offsets.c:13:
~/linux-3.13-rc2/arch/arm/include/asm/memory.h: In function
?__virt_to_phys?:
~/linux-3.13-rc2/arch/arm/include/asm/memory.h:244:40: error:
?PHYS_OFFSET? undeclared (first use in this function)
~/linux-3.13-rc2/arch/arm/include/asm/memory.h:244:40: note: each
undeclared identifier is reported only once for each function it appears in
~/linux-3.13-rc2/arch/arm/include/asm/memory.h: In function
?__phys_to_virt?:
~/linux-3.13-rc2/arch/arm/include/asm/memory.h:249:13: error:
?PHYS_OFFSET? undeclared (first use in this function)
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

The error does not occur if 'Patch physical to virtual translations at
runtime' is _selected_, bu the resulting kernel will not boot on the
DreamPlug..

In case there was some odd problem with the cross-compiler, I have also
reproduced the problem compiling the kernel on the DreamPlug itself..

Robert Gadsdon
December 3, 2013
