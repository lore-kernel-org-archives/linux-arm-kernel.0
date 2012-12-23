From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 23 Dec 2012 16:16:39 +0100
Subject: [PATCH 2/4] ARM: Kirkwood: Switch TWSI1 of 88f6282 to DT
Message-ID: <20121223151639.GA12697@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Clock Management of kirkwood has moved to DT clock providers.
> However, TWSI1 has not yet been done.
> This switches TWSI1 of 88f6282 to DT clock providers.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/arm/boot/dts/kirkwood-6282.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi
> +b/arch/arm/boot/dts/kirkwood-6282.dtsi
> index bc23081..ad63b88 100644
> --- a/arch/arm/boot/dts/kirkwood-6282.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
> @@ -45,6 +45,7 @@
>                         #size-cells = <0>;
>                         interrupts = <32>;
>                         clock-frequency = <100000>;
> +                       clocks = <&gate_clk 7>;
>                         status = "disabled";
>                 };
>         };

Acked-by: Andrew Lunn <andrew@lunn.ch>

Jason: This patch should be queued up for -rc2.

       Andrew
