From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 19 Jul 2018 23:23:01 +0000
Subject: [PATCH/RFT 3/7] arm64: dts: renesas: r8a77965: Add Sound device
 node and SSI support
In-Reply-To: <1531856883-19645-4-git-send-email-ykaneko0929@gmail.com>
References: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
 <1531856883-19645-4-git-send-email-ykaneko0929@gmail.com>
Message-ID: <87pnzi4xyw.wl-kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> Based on several similar patches of the R8A7796 device tree
> by Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
(snip)
>  		rcar_sound: sound at ec500000 {
> +			/*
> +			 * #sound-dai-cells is required
> +			 *
> +			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
> +			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
> +			 */
> +			/*
> +			 * #clock-cells is required for audio_clkout0/1/2/3
> +			 *
> +			 * clkout	: #clock-cells = <0>;	<&rcar_sound>;
> +			 * clkout0/1/2/3: #clock-cells = <1>;	<&rcar_sound N>;
> +			 */
> +			compatible =  "renesas,rcar_sound-r8a7796", "renesas,rcar_sound-gen3";

77965 ?

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
