From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jan 2015 16:09:27 -0800
Subject: [PATCH 4/5] arm: boot: dts: am437x-sk: add power button binding
In-Reply-To: <1419622104-25812-5-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-5-git-send-email-balbi@ti.com>
Message-ID: <20150108000926.GN13010@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141226 11:31]:
> Let this board report KEY_POWER so upper layers
> can decide what to do when power button is pressed.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applying this one into omap-for-v3.20/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 53bbfc9..c53840c 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -386,6 +386,11 @@
>  			regulator-always-on;
>  		};
>  
> +		power-button {
> +			compatible = "ti,tps65218-pwrbutton";
> +			status = "okay";
> +			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
> +		};
>  	};
>  
>  	at24 at 50 {
> -- 
> 2.2.0
> 
