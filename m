From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 20 Sep 2017 22:11:02 -0700
Subject: [PATCHv2] arm64: dts: stratix10: add ethernet/sdmmc support to
 the S10 devkit
In-Reply-To: <1505920675-9641-1-git-send-email-dinguyen@kernel.org>
References: <1505920675-9641-1-git-send-email-dinguyen@kernel.org>
Message-ID: <9fc4c173-6d98-052f-50cc-aefeeec9c264@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/20/2017 08:17 AM, Dinh Nguyen wrote:
> Enable ethernet and sdmmc support on the Stratix10 devkit.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: Create a separate PHY node

The gmac/phy nodes look fine now, thanks!

> ---
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 41ea2db..5907586 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -34,6 +34,44 @@
>  	};
>  };
>  
> +&gmac0 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&phy0>;
> +
> +	max-frame-size = <3800>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy0: ethernet-phy at 0 {
> +			reg = <4>;
> +
> +			txd0-skew-ps = <0>; /* -420ps */
> +			txd1-skew-ps = <0>; /* -420ps */
> +			txd2-skew-ps = <0>; /* -420ps */
> +			txd3-skew-ps = <0>; /* -420ps */
> +			rxd0-skew-ps = <420>; /* 0ps */
> +			rxd1-skew-ps = <420>; /* 0ps */
> +			rxd2-skew-ps = <420>; /* 0ps */
> +			rxd3-skew-ps = <420>; /* 0ps */
> +			txen-skew-ps = <0>; /* -420ps */
> +			txc-skew-ps = <1860>; /* 960ps */
> +			rxdv-skew-ps = <420>; /* 0ps */
> +			rxc-skew-ps = <1680>; /* 780ps */
> +		};
> +	};
> +};
> +
> +&mmc {
> +	status = "okay";
> +	num-slots = <1>;
> +	cap-sd-highspeed;
> +	broken-cd;
> +	bus-width = <4>;
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> 

-- 
Florian
