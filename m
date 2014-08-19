From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Tue, 19 Aug 2014 20:52:19 +0200
Subject: [PATCH 1/6] ARM: dts: Add Peach Pit and Pi dts entry for max77802
 PMIC
In-Reply-To: <1408460913-13863-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408460913-13863-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <53F39CE3.8040303@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.08.2014 17:08, schrieb Javier Martinez Canillas:
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 228a6b1..8619d58 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -144,6 +144,339 @@
>  	ddc = <&i2c_2>;
>  };
>  
> +&hsi2c_4 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	max77802-pmic at 9 {
> +		compatible = "maxim,max77802";
> +		interrupt-parent = <&gpx3>;
> +		interrupts = <1 0>;

<1 IRQ_TYPE_NONE>?

[...]
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index f3ee48b..f753eae 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -142,6 +142,339 @@
>  	ddc = <&i2c_2>;
>  };
>  
> +&hsi2c_4 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	max77802-pmic at 9 {
> +		compatible = "maxim,max77802";
> +		interrupt-parent = <&gpx3>;
> +		interrupts = <1 0>;

Dito?

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
