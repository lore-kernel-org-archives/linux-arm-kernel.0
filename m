From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Jul 2012 18:17:43 +0200
Subject: [PATCH 5/6] csb1724: Enable device tree based mv643xx ethernet
 support.
In-Reply-To: <1343661359-10150-6-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-6-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <20120730161743.GN18016@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:15:58PM +0100, Ian Molton wrote:
>     This patch enables mv643xx based ethernet built into the SoM on the
>     csb1724, via flattened device tree.
> 
>     Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  arch/arm/boot/dts/kirkwood-csb1724.dts |   25 ++++++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi        |   16 ++++++++++++
>  arch/arm/configs/csb1724_defconfig     |   45 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-csb1724.c |    3 +++
>  4 files changed, 89 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-csb1724.dts b/arch/arm/boot/dts/kirkwood-csb1724.dts
> index 44dfe9a..f652797 100644
> --- a/arch/arm/boot/dts/kirkwood-csb1724.dts
> +++ b/arch/arm/boot/dts/kirkwood-csb1724.dts
> @@ -25,6 +25,31 @@
>  			nr-ports = <2>;
>  			status = "ok";
>  		};
> +
> +		smi0: mdio at 72000 {
> +			status = "ok";
> +		};
> +
> +		smi1: mdio at 76000 {
> +			status = "ok";
> +		};
> +
> +		egiga0 {
> +			compatible = "marvell,mv643xx";
> +			mdio = <&smi0>;
> +			port_number = <0>;
> +			phy_addr = <0x80>;
> +			interrupts = <11>;
> +		};

Hi Ian

Shouldn't there be two interrupt here?

 292         orion_ge00_init(eth_data,
 293                         GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
 294                         IRQ_KIRKWOOD_GE00_ERR);

Documentation of the binding would help....

     Andrew
