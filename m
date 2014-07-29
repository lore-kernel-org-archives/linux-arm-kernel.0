From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Tue, 29 Jul 2014 14:08:51 +0200
Subject: [PATCH v8 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
In-Reply-To: <1406611711-25112-4-git-send-email-thomas.ab@samsung.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
 <1406611711-25112-4-git-send-email-thomas.ab@samsung.com>
Message-ID: <53D78ED3.9090703@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Am 29.07.2014 07:28, schrieb Thomas Abraham:
> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> index 89ac90f..34bb31c 100644
> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> @@ -19,6 +19,12 @@
>  	chosen {
>  	};
>  
> +	cpus {
> +		cpu at 0 {
> +			cpu0-supply = <&buck2_reg>;
> +		};
> +	};
> +
>  	pinctrl at 11400000 {
>  		/*
>  		 * Disabled pullups since external part has its own pullups and

I've been instructed to dismantle this .dtsi file, so please place this
into exynos5250-snow.dts. It's probably wrong here anyway, since Spring
doesn't use the max77686 but an s5m6787 PMIC.

How do I find out which -supply to specify here for Spring?

Also, wouldn't it make sense to assign a cpu0 label in exynos????.dtsi
to override it via &cpu0 { ... };?

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
