From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 11:18:27 -0700
Subject: [PATCH RFC 5/6] ARM: dts: AM335x: prcm node (for reset)
In-Reply-To: <00675d65eef61eb4222e6a461ef479ebbd1d4787.1378129416.git.afzal@ti.com>
References: <cover.1378129416.git.afzal@ti.com>
 <00675d65eef61eb4222e6a461ef479ebbd1d4787.1378129416.git.afzal@ti.com>
Message-ID: <20131008181827.GH8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [130902 07:30]:
> Add AM335x prcm node with reset binding.

Please put the .dts changes into a separate series from
driver changes so the driver maintainers don't accidentally
queue also the .dts changes. This is to avoid pointless
self-inflicted merge conflicts.

Regards,

Tony
 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 4701e3c..c2ccf94 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -530,6 +530,12 @@
>  			#size-cells = <1>;
>  			status = "disabled";
>  		};
> +
> +		prcm: prcm at 44e00000 {
> +			compatible = "ti,am3352-prcm";
> +			reg = <0x44e00000 0x1300>;
> +			#reset-cells = <1>;
> +		};
>  	};
>  
>  	clocks {
> -- 
> 1.8.3.4
> 
