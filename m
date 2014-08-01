From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 01 Aug 2014 13:42:57 +0200
Subject: [PATCH v5 06/10] ARM: dts: Clean up exynos5250-smdk5250
In-Reply-To: <1406868897-26874-7-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-7-git-send-email-afaerber@suse.de>
Message-ID: <53DB7D41.2070000@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.08.2014 06:54, schrieb Andreas F?rber:
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index ff1c09607631..30482fc523f9 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -215,7 +215,7 @@
>  		clock-names = "fimg2d";
>  	};
>  
> -	codec at 11000000 {
> +	codec: codec at 11000000 {
>  		compatible = "samsung,mfc-v6";
>  		reg = <0x11000000 0x10000>;
>  		interrupts = <0 96 0>;

I notice that Ajay's iommu patch uses mfc here, so let's use it here,
too. Affects patches 7 and 10.

Andreas

> @@ -258,7 +258,7 @@
>  		clock-names = "uart", "clk_uart_baud0";
>  	};
>  
> -	sata at 122F0000 {
> +	sata: sata at 122F0000 {
>  		compatible = "snps,dwc-ahci";
>  		samsung,sata-freq = <66>;
>  		reg = <0x122F0000 0x1ff>;

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
