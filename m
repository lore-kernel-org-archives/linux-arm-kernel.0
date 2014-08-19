From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Tue, 19 Aug 2014 20:37:44 +0200
Subject: [PATCH 5/6] ARM: dts: Add vmmc and vqmmc supplies for Peach Pit
 and Pi boards
In-Reply-To: <1408460913-13863-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408460913-13863-6-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <53F39978.3080901@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Am 19.08.2014 17:08, schrieb Javier Martinez Canillas:
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 8e50042..5b9dbb9 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -547,6 +547,8 @@
>  };
>  
>  &mmc_2 {
> +	vmmc-supply = <&tps65090_fet4>;
> +	vqmmc-supply = <&vqmmc_sdcard>;
>  	status = "okay";
>  	num-slots = <1>;
>  	supports-highspeed;
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 939f91c..dcac443 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -545,6 +545,8 @@
>  };
>  
>  &mmc_2 {
> +	vmmc-supply = <&tps65090_fet4>;
> +	vqmmc-supply = <&vqmmc_sdcard>;
>  	status = "okay";
>  	num-slots = <1>;
>  	supports-highspeed;

A convention that I picked up was to place overridden status property
first. Do your new properties really need to go before that?

Also, if you look at today's for-next, then supports-highspeed should be
cap-{sd,mmc}-highspeed, so it may be worth to rebase.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
