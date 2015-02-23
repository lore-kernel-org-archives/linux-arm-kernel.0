From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 23 Feb 2015 00:28:42 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add SDHI DT support
In-Reply-To: <4571288.SFHfW35Ob9@wasted.cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <4571288.SFHfW35Ob9@wasted.cogentembedded.com>
Message-ID: <87oaolpj0c.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei, Magnus, Simon

> Define the generic R8A7794 parts of the SDHI[012] device nodes.
> 
> Based on the orginal patch by Shinobu Uehara <shinobu.uehara.xc@renesas.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
(snip)
> +	sdhi0: sd at ee100000 {
> +		compatible = "renesas,sdhi-r8a7794";
> +		reg = <0 0xee100000 0 0x200>;
> +		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
> +		status = "disabled";
> +	};
> +
> +	sdhi1: sd at ee140000 {
> +		compatible = "renesas,sdhi-r8a7794";
> +		reg = <0 0xee140000 0 0x100>;
> +		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
> +		status = "disabled";
> +	};
> +
> +	sdhi2: sd at ee160000 {
> +		compatible = "renesas,sdhi-r8a7794";
> +		reg = <0 0xee160000 0 0x100>;
> +		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
> +		status = "disabled";
> +	};

This patch and r8a7791.dtsi have sdhi0/1/2.
But, according to datasheet, it is sdhi0/2/3.
(Only R-Car H2 have sdhi1)

I don't care so match about this, but
I think following datasheet is no-confusion if possible.

Best regards
---
Kuninori Morimoto
