From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 17 Jun 2010 17:19:54 +0800
Subject: [PATCH 07/10] arm/zImage: don't define unused symbol initrd_phys
In-Reply-To: <1276165636-20150-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-7-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTilac0HGok-e571zfZTNIoxWEVSweOshwwL_JNnV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> The only user of initrd_phys is arch/arm/boot/bootp/init.S which still
> gets the value passed to.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Eric Miao <eric.miao@canonical.com>

> ---
> ?arch/arm/boot/compressed/Makefile | ? ?9 +++------
> ?1 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 53faa90..5419448 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -79,16 +79,13 @@ endif
> ?EXTRA_CFLAGS ?:= -fpic -fno-builtin
> ?EXTRA_AFLAGS ?:= -Wa,-march=all
>
> -# Supply ZRELADDR, INITRD_PHYS and PARAMS_PHYS to the decompressor via
> -# linker symbols. ?We only define initrd_phys and params_phys if the
> -# machine class defined the corresponding makefile variable.
> +# Supply ZRELADDR and PARAMS_PHYS to the decompressor via linker symbols. ?We
> +# only define params_phys if the machine class defined the corresponding
> +# makefile variable.
> ?LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
> ?ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> ?LDFLAGS_vmlinux += --be8
> ?endif
> -ifneq ($(INITRD_PHYS),)
> -LDFLAGS_vmlinux += --defsym initrd_phys=$(INITRD_PHYS)
> -endif
> ?ifneq ($(PARAMS_PHYS),)
> ?LDFLAGS_vmlinux += --defsym params_phys=$(PARAMS_PHYS)
> ?endif
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
