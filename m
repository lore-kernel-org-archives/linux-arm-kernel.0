From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 20 Nov 2015 22:19:32 +0100
Subject: [PATCH 2/2] arm64: dts: berlin4ct: enable all i2c nodes for the
 STB board
In-Reply-To: <1448012821-7413-3-git-send-email-jszhang@marvell.com>
References: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
 <1448012821-7413-3-git-send-email-jszhang@marvell.com>
Message-ID: <564F8E64.7020606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.2015 10:47, Jisheng Zhang wrote:
> Enable all i2c nodes for the Marvell berlin BG4CT STB board.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 50 +++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
> index 348c37e..9e8e2e0 100644
> --- a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
> @@ -61,6 +61,56 @@
>  	};
>  };
>  
> +&avio_pinctrl {
> +	twsi1_pmux: twsi1-pmux {
> +		groups = "TX_EDDC_SCL", "TX_EDDC_SDA";
> +		function = "tx_eddc";
> +	};

Please keep the pinmux sub-nodes in the SoC dtsi as long
as they are not strictly board specific, i.e. gpios.

> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-0 = <&twsi0_pmux>;
> +	pinctrl-names = "default";

If there is only one (or a default) pinctrl-0 option for i2c0,
you can also move it to the SoC dtsi.

> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-0 = <&twsi1_pmux>;
> +	pinctrl-names = "default";

ditto.

> +};
> +
> +&i2c2 {
> +	status = "okay";
> +	pinctrl-0 = <&twsi2_pmux>;
> +	pinctrl-names = "default";

ditto.

> +};
> +
> +&i2c3 {
> +	status = "okay";
> +	pinctrl-0 = <&twsi3_pmux>;
> +	pinctrl-names = "default";

ditto.

> +};
> +
> +&soc_pinctrl {
> +	twsi0_pmux: twsi0-pmux {
> +		groups = "TW0_SCL", "TW0_SDA";
> +		function = "tw0";
> +	};

Same comment about moving pinmux nodes to SoC dtsi.

> +};
> +
> +&system_pinctrl {
> +	twsi2_pmux: twsi2-pmux {
> +		groups = "SM_TW2_SCL", "SM_TW2_SDA";
> +		function = "tw2";
> +	};
> +
> +	twsi3_pmux: twsi3-pmux {
> +		groups = "SM_TW3_SCL", "SM_TW3_SDA";
> +		function = "tw3";
> +	};

ditto.

Sebastian

> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> 
