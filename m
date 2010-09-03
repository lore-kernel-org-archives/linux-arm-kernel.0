From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 3 Sep 2010 21:40:37 +0800
Subject: [PATCH 3/7] ARM: specify ZRELADDR for ARCH_H720X
In-Reply-To: <1283507818-1573-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTik1BBPxY==3zzHdk5mH-Esq6KRxNtfX5uhXAza_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> This was missed in commit
>
> ? ? ? ?e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This is straight-forward. Ack.

> ---
> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ?| ? ?4 +++-
> ?arch/arm/mach-h720x/Makefile.boot | ? ?2 --
> ?2 files changed, 3 insertions(+), 3 deletions(-)
> ?delete mode 100644 arch/arm/mach-h720x/Makefile.boot
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 16bc8eb..c43b508 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1620,7 +1620,9 @@ config ZRELADDR
> ? ? ? ? ? ? ? ?ARCH_S3C2416 ||\
> ? ? ? ? ? ? ? ?ARCH_S3C2440 ||\
> ? ? ? ? ? ? ? ?ARCH_S3C2443
> - ? ? ? default 0x40008000 if ARCH_STMP378X ||\
> + ? ? ? default 0x40008000 if \
> + ? ? ? ? ? ? ? ARCH_H720X ||\
> + ? ? ? ? ? ? ? ARCH_STMP378X ||\
> ? ? ? ? ? ? ? ?ARCH_STMP37XX ||\
> ? ? ? ? ? ? ? ?ARCH_SH7372 ||\
> ? ? ? ? ? ? ? ?ARCH_SH7377 ||\
> diff --git a/arch/arm/mach-h720x/Makefile.boot b/arch/arm/mach-h720x/Makefile.boot
> deleted file mode 100644
> index 5298401..0000000
> --- a/arch/arm/mach-h720x/Makefile.boot
> +++ /dev/null
> @@ -1,2 +0,0 @@
> - ? zreladdr-$(CONFIG_ARCH_H720X) ? ? ? := 0x40008000
> -
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
