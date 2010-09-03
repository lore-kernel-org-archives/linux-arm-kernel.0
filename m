From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 3 Sep 2010 21:41:21 +0800
Subject: [PATCH 4/7] ARM: specify ZRELADDR for ARCH_LPC32XX
In-Reply-To: <1283507818-1573-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTi=HfoxOQEAODXJ+6p=eL7bqRnQG35vx_mWy9D7E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> This was missed in commit
>
> ? ? ? ?e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)
>
> Cc: Kevin Wells <wellsk40@gmail.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Looks straight-forward. Ack.

> ---
> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ?| ? ?4 +++-
> ?arch/arm/mach-lpc32xx/Makefile.boot | ? ?1 -
> ?2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c43b508..4a9a55c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1630,7 +1630,9 @@ config ZRELADDR
> ? ? ? ?default 0x50008000 if ARCH_S3C64XX ||\
> ? ? ? ? ? ? ? ?ARCH_SH7367
> ? ? ? ?default 0x60008000 if ARCH_VEXPRESS
> - ? ? ? default 0x80008000 if ARCH_MX25 ||\
> + ? ? ? default 0x80008000 if \
> + ? ? ? ? ? ? ? ARCH_LPC32XX ||\
> + ? ? ? ? ? ? ? ARCH_MX25 ||\
> ? ? ? ? ? ? ? ?ARCH_MX3 ||\
> ? ? ? ? ? ? ? ?ARCH_NETX ||\
> ? ? ? ? ? ? ? ?ARCH_OMAP2PLUS ||\
> diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
> index b796b41..e6bde79 100644
> --- a/arch/arm/mach-lpc32xx/Makefile.boot
> +++ b/arch/arm/mach-lpc32xx/Makefile.boot
> @@ -1,4 +1,3 @@
> - ? zreladdr-y ?:= 0x80008000
> ?params_phys-y ?:= 0x80000100
> ?initrd_phys-y ?:= 0x82000000
>
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
