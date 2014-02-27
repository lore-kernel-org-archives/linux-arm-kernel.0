From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 26 Feb 2014 16:16:20 -0800
Subject: [PATCH 3/3] ARM: S3C24XX: select COMMON_CLK_SAMSUNG for S3C24XX
In-Reply-To: <1393392247-6247-4-git-send-email-pankaj.dubey@samsung.com>
References: <1393392247-6247-1-git-send-email-pankaj.dubey@samsung.com>
 <1393392247-6247-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140227001620.12081.28601@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pankaj Dubey (2014-02-25 21:24:07)
> CC: Ben Dooks <ben-linux@fluff.org>
> CC: Kukjin Kim <kgene.kim@samsung.com>
> CC: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-s3c24xx/Kconfig |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 80373da..5cf82a1 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -40,6 +40,7 @@ config CPU_S3C2410
>  config CPU_S3C2412
>         bool "SAMSUNG S3C2412"
>         select COMMON_CLK
> +       select COMMON_CLK_SAMSUNG

I guess this depends on Heiko's "[PATCH 00/12] ARM: S3C24XX: convert
s3c2410, s3c2440 s3c2442 to common clock framework" series?

Regards,
Mike

>         select CPU_ARM926T
>         select CPU_LLSERIAL_S3C2440
>         select S3C2412_COMMON_CLK
> @@ -51,6 +52,7 @@ config CPU_S3C2412
>  config CPU_S3C2416
>         bool "SAMSUNG S3C2416/S3C2450"
>         select COMMON_CLK
> +       select COMMON_CLK_SAMSUNG
>         select CPU_ARM926T
>         select CPU_LLSERIAL_S3C2440
>         select S3C2416_PM if PM
> @@ -89,6 +91,7 @@ config CPU_S3C244X
>  config CPU_S3C2443
>         bool "SAMSUNG S3C2443"
>         select COMMON_CLK
> +       select COMMON_CLK_SAMSUNG
>         select CPU_ARM920T
>         select CPU_LLSERIAL_S3C2440
>         select S3C2443_COMMON_CLK
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
