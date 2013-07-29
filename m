From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 29 Jul 2013 15:11:54 +0100
Subject: [PATCH 05/10] ARM: sunxi: Add Allwinner A31 DTSI
In-Reply-To: <1374618312-19001-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130729141154.GB25264@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 11:25:07PM +0100, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile       |   3 +-
>  arch/arm/boot/dts/sun6i-a31.dtsi | 155 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun6i-a31.dtsi

[...]

> +	soc at 01c20000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x01c20000 0x300000>;

That's unnecessary, nothing should be using this for a simple-bus.

> +		ranges;
> +
> +		timer at 01c20c00 {
> +			compatible = "allwinner,sun4i-timer";
> +			reg = <0x01c20c00 0xa0>;
> +			interrupts = <
> +					0 18 1
> +					0 19 1
> +					0 20 1
> +					0 21 1
> +					0 22 1
> +					>;

A cosmetic issue, but this would be nicer with each tuple bracketed:

			interrupts = <0 18 1>,
				     <0 19 1>,
				     <0 20 1>,
				     <0 21 1>,
				     <0 22 1>;

> +			clocks = <&osc>;
> +		};

Thanks,
Mark.
