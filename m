From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 14:03:36 -0500
Subject: [PATCH v2 1/5] ARM: Kirkwood: Add audio node to kirkwood.dtsi
In-Reply-To: <1393264898-28939-2-git-send-email-andrew@lunn.ch>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
 <1393264898-28939-2-git-send-email-andrew@lunn.ch>
Message-ID: <20140224190336.GC1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 07:01:34PM +0100, Andrew Lunn wrote:
> The binding has existed for a while, so add the missing node so it can
> be used by devices.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2:
> Tabify
> ---
>  arch/arm/boot/dts/kirkwood.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 7b921b30cfcb..180dc69ff742 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -310,5 +310,14 @@
>  			#phy-cells = <0>;
>  			status = "ok";
>  		};
> +
> +		audio0: audio-controller at a0000 {
> +			compatible = "marvell,kirkwood-audio";
> +			reg = <0xa0000 0x2210>;
> +			interrupts = <24>;
> +			clocks = <&gate_clk 9>;
> +			clock-names = "internal";
> +			status = "disabled";
> +                };

leading whitespace before brace.

thx,

Jason.

>  	};
>  };
> -- 
> 1.8.5.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
