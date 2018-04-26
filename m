From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 27 Apr 2018 00:22:32 +0300
Subject: [PATCH 16/17] arm64: dts: r8a77965-salvator-xs: Add DU external
 dot clocks
In-Reply-To: <20180426165346.494-17-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-17-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <2242585.ilfyDprk4a@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:45 EEST Kieran Bingham wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> The DU1 external dot clock is provided by the fixed frequency clock
> generator X21, while the DU0 and DU3 clocks are provided by the
> programmable Versaclock6 clock generator.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts index
> a83a00deed9e..2223cc2bd6bc 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
> @@ -19,3 +19,15 @@
>  		reg = <0x0 0x48000000 0x0 0x78000000>;
>  	};
>  };
> +
> +&du {
> +	clocks = <&cpg CPG_MOD 724>,
> +		 <&cpg CPG_MOD 723>,
> +		 <&cpg CPG_MOD 721>,
> +		 <&cpg CPG_MOD 727>,
> +		 <&versaclock6 1>,
> +		 <&x21_clk>,
> +		 <&versaclock6 2>;
> +	clock-names = "du.0", "du.1", "du.3", "lvds.0",
> +		      "dclkin.0", "dclkin.1", "dclkin.3";

There's no LVDS clock in the DU anymore, you can drop it.

As for patch 14/17, I think you can squash this one with 17/17.

> +};

-- 
Regards,

Laurent Pinchart
