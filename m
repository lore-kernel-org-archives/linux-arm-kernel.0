From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 10 Feb 2016 03:12:02 +0000
Subject: [PATCH v2 5/5] ARM: dts: r8a7794: add sound support
In-Reply-To: <2543047.yYrDdYb9v5@wasted.cogentembedded.com>
References: <12033353.rt0nolnBmD@wasted.cogentembedded.com>
 <2543047.yYrDdYb9v5@wasted.cogentembedded.com>
Message-ID: <87lh6ts1o0.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei, again

> Define the generic R8A7794 part of  the sound device node.
> This sound device  is a complex one and comprises the Audio Clock Generator
> (ADG), Sampling Rate Converter Unit (SCU), Serial Sound Interface [Unit]
> (SSI[U]), and Audio DMAC-Peripheral-Peripheral.
> It is up  to the board file to enable the device.
> 
> This patch is based on the R8A7791 sound work by Kuninori Morimoto.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
(snip)
> +		clocks = <&mstp10_clks R8A7794_CLK_SSI_ALL>,
> +			 <&mstp10_clks R8A7794_CLK_SSI9>,
> +			 <&mstp10_clks R8A7794_CLK_SSI8>,
> +			 <&mstp10_clks R8A7794_CLK_SSI7>,
> +			 <&mstp10_clks R8A7794_CLK_SSI6>,
> +			 <&mstp10_clks R8A7794_CLK_SSI5>,
> +			 <&mstp10_clks R8A7794_CLK_SSI4>,
> +			 <&mstp10_clks R8A7794_CLK_SSI3>,
> +			 <&mstp10_clks R8A7794_CLK_SSI2>,
> +			 <&mstp10_clks R8A7794_CLK_SSI1>,
> +			 <&mstp10_clks R8A7794_CLK_SSI0>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC9>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC8>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC7>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC6>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC5>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC4>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC3>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC2>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC1>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC0>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_DVC0>,
> +			 <&mstp10_clks R8A7794_CLK_SCU_DVC1>,
> +			 <&audio_clka>, <&audio_clkb>, <&audio_clkc>,
> +			 <&m2_clk>;
> +		clock-names = "ssi-all",
> +			      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
> +			      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
> +			      "src.9", "src.8", "src.7", "src.6", "src.5",
> +			      "src.4", "src.3", "src.2", "src.1", "src.0",
> +			      "ctu.0", "ctu.1",
> +			      "mix.0", "mix.1",
> +			      "dvc.0", "dvc.1",
> +			      "clk_a", "clk_b", "clk_c", "clk_i";

I'm sorry about my previous email. I think I made you confuse.
I meant you can remove CTU/MIX field if your patch doesn't care these.
