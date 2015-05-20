From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 10:11:46 -0700
Subject: [PATCH] ARM: dts: add core2 padconf region for am3517
In-Reply-To: <1431293273-19321-1-git-send-email-andrej.skvortzov@gmail.com>
References: <1431293273-19321-1-git-send-email-andrej.skvortzov@gmail.com>
Message-ID: <20150520171146.GX10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrey Skvortsov <andrej.skvortzov@gmail.com> [150510 14:29]:
> According to the technical reference manual for AM35xx system
> controller module (SCM) PADCONFS core registers are divided in two
> regions: 0x48002030..0x48002268 and 0x480025d8..0x480025FC.
> First region is the same for all omap3 SoC and is described in omap3.dtsi.
> The second region is the same as in omap34xx (see omap34xx.dtsi)
> and omap35xx. The patch adds missing description for the second region.
> This patch was tested on AM3517.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Applying into omap-for-v4.2/dt thanks.

Tony

> Commit 3d495383648a ("ARM: dts: Split omap3 pinmux core device") notes that
> Nishanth Menon <nm@ti.com> said that 3517 does not have padconf2 region.
> Unfortunately I couldn't find reference to his post on mailing list.
> This patch was tested on AM3517 SoC and original vendor code contains
> pinmuxing for this second region as well.
> 
>  arch/arm/boot/dts/am3517.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
> index c90724b..2534500 100644
> --- a/arch/arm/boot/dts/am3517.dtsi
> +++ b/arch/arm/boot/dts/am3517.dtsi
> @@ -60,5 +60,16 @@
>  			dma-names = "tx", "rx";
>  			clock-frequency = <48000000>;
>  		};
> +
> +		omap3_pmx_core2: pinmux at 480025D8 {
> +			compatible = "ti,omap3-padconf", "pinctrl-single";
> +			reg = <0x480025D8 0x24>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			pinctrl-single,register-width = <16>;
> +			pinctrl-single,function-mask = <0xff1f>;
> +		};
>  	};
>  };
