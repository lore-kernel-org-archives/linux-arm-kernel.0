From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Apr 2018 22:47:54 +0800
Subject: [PATCH V3] ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM
 and PDK2
In-Reply-To: <20180318173403.31460-1-marex@denx.de>
References: <20180318173403.31460-1-marex@denx.de>
Message-ID: <20180416144753.GK25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 06:34:03PM +0100, Marek Vasut wrote:
> +&i2c2 {
> +	sgtl5000: codec at a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;

Since commit c4e50b1d87fb ("ASoC: sgtl5000: Pass the required
'#sound-dai-cells'"), #sound-dai-cells is required for sgtl5000 device.
I added the following line here, and applied the patch.

	#sound-dai-cells = <0>;

Shawn

> +		clocks = <&clk_ext_audio_codec>;
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +	};
> +};
