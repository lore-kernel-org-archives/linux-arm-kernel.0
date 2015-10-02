From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 2 Oct 2015 15:26:05 +0200
Subject: [PATCH v2 6/6] arm64: dts: berlin4ct: add default pinmux for uart0
In-Reply-To: <1442829860-4647-7-git-send-email-jszhang@marvell.com>
References: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
 <1442829860-4647-7-git-send-email-jszhang@marvell.com>
Message-ID: <20151002132605.GF3162@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng,

Please s/urt/uart/ in this patch.

Thanks!

Antoine

On Mon, Sep 21, 2015 at 06:04:20PM +0800, Jisheng Zhang wrote:
> Add urt0 txd and rxd muxing setup in the dtsi because uart0 always uses
> them to work, no other possibilities.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> index c374f1d..e9409ec 100644
> --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> @@ -288,12 +288,19 @@
>  				clocks = <&osc>;
>  				reg-shift = <2>;
>  				status = "disabled";
> +				pinctrl-0 = <&urt0_pmux>;
> +				pinctrl-names = "default";
>  			};
>  		};
>  
>  		sm_pinctrl: pinctrl at fe2200 {
>  			compatible = "marvell,berlin4ct-sm-pinctrl";
>  			reg = <0xfe2200 0xc>;
> +
> +			urt0_pmux: urt0-pmux {
> +				groups = "SM_URT0_TXD", "SM_URT0_RXD";
> +				function = "urt0";
> +			};
>  		};
>  	};
>  };
> -- 
> 2.5.3
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
