From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 12 Jun 2014 16:07:53 +0200
Subject: [PATCH 3/3 v4] ARM: DTS: fix the chip select gpios definition
 in the SPI nodes
In-Reply-To: <1402578821-27338-3-git-send-email-ch.naveen@samsung.com>
References: <1402578821-27338-1-git-send-email-ch.naveen@samsung.com>
 <1402578821-27338-3-git-send-email-ch.naveen@samsung.com>
Message-ID: <5399B439.1010300@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Naveen,

On 06/12/2014 03:13 PM, Naveen Krishna Chatradhi wrote:
> This patch replaces the "cs-gpio" from "controller-data" node
> as was specified in the old binding and use the standard
> "cs-gpios" property expected by the SPI core as is defined in
> the new binding.
> 
> Respective changes are preposed to spi-s3c64xx.c driver.
> @ http://www.spinics.net/lists/linux-samsung-soc/msg32282.html
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 +-
>  arch/arm/boot/dts/exynos4412-trats2.dts   |    2 +-
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> index 636d166..9191491 100644
> --- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
> +++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> @@ -169,6 +169,7 @@
>  
>  	spi_2: spi at 13940000 {
>  		status = "okay";
> +		cs-gpios = <&gpc1 2 0>;
>  
>  		w25x80 at 0 {
>  			#address-cells = <1>;
> @@ -178,7 +179,6 @@
>  			spi-max-frequency = <1000000>;
>  
>  			controller-data {
> -				cs-gpio = <&gpc1 2 0>;
>  				samsung,spi-feedback-delay = <0>;
>  			};
>  
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 8a558b7..204b0de 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -512,6 +512,7 @@
>  	spi_1: spi at 13930000 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&spi1_bus>;
> +		cs-gpios = <&gpb 5 0>;
>  		status = "okay";
>  
>  		s5c73m3_spi: s5c73m3 {
> @@ -519,7 +520,6 @@
>  			spi-max-frequency = <50000000>;
>  			reg = <0>;
>  			controller-data {
> -				cs-gpio = <&gpb 5 0>;
>  				samsung,spi-feedback-delay = <2>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index a794a70..0c6433a 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -316,6 +316,7 @@
>  	};
>  
>  	spi_1: spi at 12d30000 {
> +		cs-gpios = <&gpa2 5 0>;
>  		status = "okay";
>  
>  		w25q80bw at 0 {
> @@ -326,7 +327,6 @@
>  			spi-max-frequency = <1000000>;
>  
>  			controller-data {
> -				cs-gpio = <&gpa2 5 0>;
>  				samsung,spi-feedback-delay = <0>;
>  			};
>  
> 

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
