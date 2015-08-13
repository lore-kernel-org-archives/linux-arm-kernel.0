From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 13 Aug 2015 09:38:10 +0900
Subject: [PATCH] ARM: dts: exynos4412-odroidu3: Enable SPI1.
In-Reply-To: <1439378871-28117-1-git-send-email-aballier@gentoo.org>
References: <1439378871-28117-1-git-send-email-aballier@gentoo.org>
Message-ID: <55CBE6F2.9030405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.08.2015 20:27, Alexis Ballier wrote:
> SPI1 is available on IO Port #2 (as depicted on their website) in
> PCB Revision 0.5 of Hardkernel Odroid U3 board.
> The shield connects a 256KiB spi-nor flash on that bus.
> 
> Signed-off-by: Alexis Ballier <aballier@gentoo.org>
> ---
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> index 44684e5..37698e4 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -61,3 +61,10 @@
>  		"Speakers", "SPKL",
>  		"Speakers", "SPKR";
>  };
> +
> +&spi_1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_bus>;
> +	cs-gpios = <&gpb 5 0>;

Please use GPIO_ACTIVE_HIGH.

Best regards,
Krzysztof

> +	status = "okay";
> +};
> 
