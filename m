From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 9 Oct 2015 11:06:40 +0200
Subject: [PATCH v4 5/6] arm64: dts: berlin4ct: add the pinctrl node
In-Reply-To: <1444378629-3057-6-git-send-email-jszhang@marvell.com>
References: <1444378629-3057-1-git-send-email-jszhang@marvell.com>
 <1444378629-3057-6-git-send-email-jszhang@marvell.com>
Message-ID: <20151009090640.GE2842@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 04:17:08PM +0800, Jisheng Zhang wrote:
> Add the avio, soc, sm pinctrl nodes for Marvell berlin4ct SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> index a3b5f1d..8e66355 100644
> --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> @@ -225,6 +225,16 @@
>  			};
>  		};
>  
> +		soc_pinctrl: pin-controller at ea8000 {
> +			compatible = "marvell,berlin4ct-soc-pinctrl";
> +			reg = <0xea8000 0x14>;
> +		};
> +
> +		avio_pinctrl: pin-controller at ea8400 {
> +			compatible = "marvell,berlin4ct-avio-pinctrl";
> +			reg = <0xea8400 0x8>;
> +		};
> +
>  		apb at fc0000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> @@ -280,5 +290,10 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		system_pinctrl: pin-controller at fe2200 {
> +			compatible = "marvell,berlin4ct-system-pinctrl";
> +			reg = <0xfe2200 0xc>;
> +		};
>  	};
>  };
> -- 
> 2.6.1
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
