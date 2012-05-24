From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 May 2012 16:43:27 +0900
Subject: [PATCH 5/6] ARM: dts: Add nodes for spi controllers for Samsung
 Exynos4 platforms
In-Reply-To: <1337334392-6441-6-git-send-email-thomas.abraham@linaro.org>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
 <1337334392-6441-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <006c01cd3980$e814b240$b83e16c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> Add device nodes for the three instances of spi controllers in Exynos4
> platforms. Enable instance spi 2 for smdkv310 board and disable all
> spi instances for origen board.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts   |   12 ++++++++
>  arch/arm/boot/dts/exynos4210-smdkv310.dts |   44
> +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi         |   30 +++++++++++++++++++
>  3 files changed, 86 insertions(+), 0 deletions(-)

[...]

> +	aliases {
> +		spi0 = &spi_0;
> +		spi1 = &spi_1;
> +		spi2 = &spi_2;
> +	};
> +

Do we need above aliases?

[...]

> 
> +	spi_2: spi at 13940000 {
> +		gpios = <&gpc1 1 5 3 0>,
> +			<&gpc1 3 5 3 0>,
> +			<&gpc1 4 5 3 0>;
> +
> +		w25x80 at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "w25x80";
> +			reg = <0>;
> +			spi-max-frequency = <10000>;
> +
> +			controller-data {
> +				cs-gpio = <&gpc1 2 1 0 3>;
> +				samsung,spi-feedback-delay = <0>;
> +			};
> +
> +			partition at 0 {
> +				label = "U-Boot";
> +				reg = <0x0 0x40000>;
> +				read-only;
> +			};
> +
> +			partition at 40000 {
> +				label = "Kernel";
> +				reg = <0x40000 0xc0000>;
> +			};
> +		};
> +	};
> +


Is there a serial flash(w25x80) is connected via SPI2 on smdkv310?

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
