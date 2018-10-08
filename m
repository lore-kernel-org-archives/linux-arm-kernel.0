From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 8 Oct 2018 09:28:58 +0200
Subject: [PATCH v2 3/6] arm64: dts: allwinner: axp803: add AC and battery
 power supplies
In-Reply-To: <20181006211836.28253-4-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-4-oskari@lemmela.net>
Message-ID: <20181008072858.kwhht67idbmevxyv@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:33AM +0300, Oskari Lemmela wrote:
> AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
> AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> index e5eae8bafc42..533987b2fe7a 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -49,6 +49,37 @@
>  	interrupt-controller;
>  	#interrupt-cells = <1>;
>  
> +	axp_adc: adc {
> +		compatible = "x-powers,axp813-adc";
> +		#io-channel-cells = <1>;
> +	};
> +
> +	axp_gpio: gpio {
> +		compatible = "x-powers,axp813-gpio";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio0_ldo: gpio0-ldo {
> +			pins = "GPIO0";
> +			function = "ldo";
> +		};
> +
> +		gpio1_ldo: gpio1-ldo {
> +			pins = "GPIO1";
> +			function = "ldo";
> +		};
> +	};
> +
> +	ac_power_supply: ac-power-supply {
> +		compatible = "x-powers,axp813-ac-power-supply";
> +		status = "disabled";
> +	};
> +

Same as the patch before, I'd put it before axp_adc.

Thanks,
Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/e053cfd6/attachment.sig>
