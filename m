From: eltshanli@gmail.com (Li Jie)
Date: Sun, 22 Nov 2009 20:19:21 +0800
Subject: [PATCH] Add GDMA API for w90p910 platform
In-Reply-To: <713d0d430911220122x68aecb28w1a1d804b4b9c765a@mail.gmail.com>
References: <713d0d430911220122x68aecb28w1a1d804b4b9c765a@mail.gmail.com>
Message-ID: <8fb2581d0911220419w7180e2d0x63fbe9278c9e6e2a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2009 at 5:22 PM, Hu Ruihuan <specter118@gmail.com> wrote:
> Dear sir,
>
> GDMA controller provides a data transfer mechanism,it can move data
> from memory to memory or memory to external devices without cpu's
> action,Now it is a API PATCH to 910 platform.
>
> Add GDMA API for w90p910 platform
> Signed-off-by: Hu Ruihuan<specter118@gmail.com>
> ----------------------
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/dma.c

I suggest you use 'git format-patch'

> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile ? ? 2009-11-20
> 06:32:38.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile ? ? ?2010-11-20
> 00:02:07.000000000 +0800
> @@ -5,7 +5,7 @@
> ?# Object file lists.
>
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?:= irq.o time.o mfp.o gpio.o clock.o
> -obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o dma.o
> ?# W90X900 CPU support files
>
> ?obj-$(CONFIG_CPU_W90P910) ? ? ?+= nuc910.o
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.orig
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.orig
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.orig ? ? ? ?1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.orig 2007-11-22
> 13:32:42.000000000 +0800
> @@ -0,0 +1,19 @@
> +#
> +# Makefile for the linux kernel.
> +#
> +
> +# Object file lists.
> +
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?:= irq.o time.o mfp.o gpio.o clock.o
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o
> +# W90X900 CPU support files
> +
> +obj-$(CONFIG_CPU_W90P910) ? ? ?+= nuc910.o
> +obj-$(CONFIG_CPU_NUC950) ? ? ? += nuc950.o
> +obj-$(CONFIG_CPU_NUC960) ? ? ? += nuc960.o
> +
> +# machine support
> +
> +obj-$(CONFIG_MACH_W90P910EVB) ?+= mach-nuc910evb.o
> +obj-$(CONFIG_MACH_W90P950EVB) ?+= mach-nuc950evb.o
> +obj-$(CONFIG_MACH_W90N960EVB) ?+= mach-nuc960evb.o
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.rej
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.rej
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile.rej 1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile.rej ?2007-11-22

Makefile.rej ??
I think this file is useless, you should remove it from your patch.

-- 
Regards
Li Jie
