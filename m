From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 14 Feb 2014 19:57:46 +0100
Subject: [PATCH v3 3/3] ARM: dts: add dts files for xyref5260 board
In-Reply-To: <1392385032-22015-4-git-send-email-rahul.sharma@samsung.com>
References: <1392385032-22015-1-git-send-email-rahul.sharma@samsung.com>
 <1392385032-22015-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <52FE672A.6070803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

The patch looks good, except one issue pointed inline.

On 14.02.2014 14:37, Rahul Sharma wrote:
> diff --git a/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
> new file mode 100644
> index 0000000..c4efc1e
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts

[snip]

> +&mmc_0 {
> +	status = "okay";
> +	num-slots = <1>;
> +	broken-cd;
> +	bypass-smu;
> +	supports-highspeed;
> +	supports-hs200-mode; /* 200 Mhz */
> +	fifo-depth = <0x40>;

This is a SoC-level property and it is already specified in your 
exynos5260.dtsi.

> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <0 4>;
> +	samsung,dw-mshc-ddr-timing = <0 2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> +
> +	slot at 0 {
> +		reg = <0>;
> +		bus-width = <8>;
> +	};
> +};
> +
> +&mmc_2 {
> +	status = "okay";
> +	num-slots = <1>;
> +	supports-highspeed;
> +	fifo-depth = <0x40>;

Ditto.

Best regards,
Tomasz
