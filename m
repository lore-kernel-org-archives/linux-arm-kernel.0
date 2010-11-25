From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Nov 2010 16:50:48 +0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <4CEE6AB1.7090404@ti.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<4CEE6AB1.7090404@ti.com>
Message-ID: <20101125165048.GA2367@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 07:24:57PM +0530, Anand Gadiyar wrote:
> Here's what a 'make V=1' throws up.
> 
>   ccache arm-none-linux-gnueabi-gcc -Wp,-MD,arch/arm/kernel/.swp_emulate.o.d  -nostdinc -isystem /db/omapts/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/include -I/home/userdata/a0393673/mainline/mainline/arch/arm/include -Iinclude  -include include/generated/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-omap2/include -Iarch/arm/plat-omap/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=6 -march=armv6 -mtune=arm1136j-s -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -fomit-frame-pointer -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Wa,-march=armv7-a    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(swp_emulate)"  -D"KBUILD_MODNAME=KBUILD_STR(swp_emulate)" -c
>  -o arch/arm/kernel/.tmp_swp_emulate.o arch/arm/kernel/swp_emulate.c
> /tmp/ccLscgtf.s: Assembler messages:
> /tmp/ccLscgtf.s:339: Error: selected processor does not support ARM mode `ldrexb r7,[r6]'
> /tmp/ccLscgtf.s:340: Error: selected processor does not support ARM mode `strexb r3,r2,[r6]'
> make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
> make: *** [arch/arm/kernel/] Error 2

Please do:

make V=1 CFLAGS_KERNEL=-v arch/arm/kernel/swp_emulate.o

and send the output.  This should show what command arguments are being
passed to the assembler.
