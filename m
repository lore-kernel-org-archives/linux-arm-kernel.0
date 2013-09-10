From: csd@broadcom.com (Christian Daudt)
Date: Tue, 10 Sep 2013 15:32:26 -0700
Subject: [PATCH v9 3/3] ARM: bcm281xx: Add device node for the GPIO
 controller
In-Reply-To: <1378836423-12467-4-git-send-email-markus.mayer@linaro.org>
References: <1378836423-12467-1-git-send-email-markus.mayer@linaro.org>
 <1378836423-12467-4-git-send-email-markus.mayer@linaro.org>
Message-ID: <522F9DFA.8000807@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-09-10 11:07 AM, Markus Mayer wrote:
> Add the GPIO controller device node for the Broadcom bcm281xx family of
> mobile SoCs.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/arm/boot/dts/bcm11351.dtsi |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 05a5aab..77af396 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -68,6 +68,22 @@
>   		clock-frequency = <32768>;
>   	};
>   
> +	gpio: gpio at 35003000 {
> +		compatible = "brcm,bcm11351-gpio", "brcm,kona-gpio";
> +		reg = <0x35003000 0x800>;
> +		interrupts =
> +		       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
> +			GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
> +			GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
> +			GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
> +			GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
> +			GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +		#gpio-cells = <2>;
> +		#interrupt-cells = <2>;
> +		gpio-controller;
> +		interrupt-controller;
> +	};
> +
>   	sdio1: sdio at 3f180000 {
>   		compatible = "brcm,kona-sdhci";
>   		reg = <0x3f180000 0x10000>;
Applied to bcm armsoc/for-3.13/dt

  thanks,
    csd
