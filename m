From: robherring2@gmail.com (Rob Herring)
Date: Fri, 6 Aug 2010 13:14:53 -0500
Subject: Impossible constraint in 'asm' in 2.6.35 build
In-Reply-To: <346052.84371.qm@web51008.mail.re2.yahoo.com>
References: <346052.84371.qm@web51008.mail.re2.yahoo.com>
Message-ID: <AANLkTi=tGh7GhVQyy-Wno-uindo-5i1kK8py2L9Jxant@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,

It is due to this commit and using gcc 4.1.2:

commit 398aa66827155ef52bab58bebd24597d90968929
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Jul 8 10:59:16 2010 +0100

    ARM: 6212/1: atomic ops: add memory constraints to inline asm

It works fine for me with CS 4.3.3 toolchain.

Rob

On Fri, Aug 6, 2010 at 12:32 PM, Fabio Estevam <fabioestevam@yahoo.com> wrote:
> Hi,
>
> I am trying to build a 2.6.35 kernel for i.MX31 and I am getting the following error:
>
> ?CC ? ? ?arch/arm/plat-mxc/audmux-v2.o
> ?CC ? ? ?arch/arm/plat-mxc/3ds_debugboard.o
> ?CC ? ? ?arch/arm/plat-mxc/devices/platform-imx-i2c.o
> ?CC ? ? ?arch/arm/plat-mxc/devices/platform-imx-uart.o
> ?CC ? ? ?arch/arm/plat-mxc/devices/platform-mxc_nand.o
> ?CC ? ? ?arch/arm/plat-mxc/devices/platform-spi_imx.o
> ?LD ? ? ?arch/arm/plat-mxc/devices/built-in.o
> ?LD ? ? ?arch/arm/plat-mxc/built-in.o
> ?CC ? ? ?arch/arm/vfp/vfpmodule.o
> ?AS ? ? ?arch/arm/vfp/entry.o
> ?AS ? ? ?arch/arm/vfp/vfphw.o
> ?LD ? ? ?arch/arm/vfp/vfp.o
> ?LD ? ? ?arch/arm/vfp/built-in.o
> ?CC ? ? ?kernel/sched.o
> kernel/sched_idletask.c: In function 'pick_next_task_idle':
> /home/fabio/pengutronix/linux-2.6/arch/arm/include/asm/atomic.h:42: error: impossible constraint in 'asm'
> make[1]: *** [kernel/sched.o] Error 1
> make: *** [kernel] Error 2
>
> I tried GCC4.3 and 4.4 and the result is the same. I haven't faced this issue when building 2.6.34.
>
> Does anyone have any suggestion?
>
> Thanks,
>
> Fabio Estevam
>
>
>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
