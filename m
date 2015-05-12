From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 May 2015 18:13:14 +0200
Subject: [PATCH 8/8] ARM: mvebu: a38x: Enable A38x XOR engine features
In-Reply-To: <1431445063-20226-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150512161314.GL19927@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 05:37:43PM +0200, Maxime Ripard wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> The new XOR engine has a new compatible of its own, together with new
> channel capabilities.
> 
> Use that new compatible now that we have a driver that can handle it.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Reviewed-by: Ofer Heifetz <oferh@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Tested-by: Nadav Haklai <nadavh@marvell.com>
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index ed2dd8ba4080..6d07b7389415 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -448,7 +448,7 @@
>  			};
>  
>  			xor at 60800 {
> -				compatible = "marvell,orion-xor";
> +				compatible = "marvell,a38x-xor";
>  				reg = <0x60800 0x100
>  				       0x60a00 0x100>;
>  				clocks = <&gateclk 22>;
> @@ -458,17 +458,13 @@
>  					interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>  					dmacap,memcpy;
>  					dmacap,xor;
> -				};
> -				xor01 {
> -					interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -					dmacap,memcpy;
> -					dmacap,xor;
> -					dmacap,memset;
> +					dmacap,pq;
> +					dmacap,interrupt;

Does this mean the hardware only has one channel?
And memset is no longer supported?

    Andrew


>  				};
>  			};
>  
>  			xor at 60900 {
> -				compatible = "marvell,orion-xor";
> +				compatible = "marvell,a38x-xor";
>  				reg = <0x60900 0x100
>  				       0x60b00 0x100>;
>  				clocks = <&gateclk 28>;
> @@ -478,12 +474,8 @@
>  					interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
>  					dmacap,memcpy;
>  					dmacap,xor;
> -				};
> -				xor11 {
> -					interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> -					dmacap,memcpy;
> -					dmacap,xor;
> -					dmacap,memset;
> +					dmacap,pq;
> +					dmacap,interrupt;
>  				};
>  			};
>  
> -- 
> 2.4.0
> 
