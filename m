From: s.peter@mpl.ch (Stefan Peter)
Date: Thu, 27 Dec 2012 23:58:06 +0100
Subject: [PATCH] ARM: Kirkwood: Fix missing clk for USB device.
In-Reply-To: <1356201902-20448-1-git-send-email-andrew@lunn.ch>
References: <1356201902-20448-1-git-send-email-andrew@lunn.ch>
Message-ID: <50DCD27E.8090804@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.12.2012 19:45, Andrew Lunn wrote:
> Without the clock being held by a driver, it ges turned off at a bad
> time causing the SoC to lockup.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 7735cee..110d6cb 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -144,6 +144,7 @@
>  			compatible = "marvell,orion-ehci";
>  			reg = <0x50000 0x1000>;
>  			interrupts = <19>;
> +			clocks = <&gate_clk 3>;
>  			status = "okay";
>  		};
>  
> 

Tested-by: Stefan Peter <s.peter@mpl.ch>



-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
