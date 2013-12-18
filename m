From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 18 Dec 2013 12:02:27 +0530
Subject: [PATCH 4/4] Phy: Add DT nodes on kirkwood and Dove for the SATA
 PHY
In-Reply-To: <1387311713-1926-4-git-send-email-andrew@lunn.ch>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-4-git-send-email-andrew@lunn.ch>
Message-ID: <52B1417B.6060909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 December 2013 01:51 AM, Andrew Lunn wrote:
> Add nodes for the two SATA PHYs on kirkwood.
> Add node for the one SATA PHY on Dove.
> Add pHandles to the PHYs in the sata nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> v1->v2:
> sata_phy at ... ->sata-phy@
> value after '@' matching the first address in the reg.
> 
> v2->v3:
> "0" -> "port0", etc.
> kirkewood -> kirkwood
> ---
>  arch/arm/boot/dts/dove.dtsi          | 11 +++++++++++
>  arch/arm/boot/dts/kirkwood-6281.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood-6282.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood.dtsi      | 18 ++++++++++++++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 113a8bc7bee7..198d03625832 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -490,10 +490,21 @@
>  				reg = <0xa0000 0x2400>;
>  				interrupts = <62>;
>  				clocks = <&gate_clk 3>;
> +				phys = <&sata_phy0>;
> +				phy-names = "port0";
>  				nr-ports = <1>;
>  				status = "disabled";
>  			};
>  
> +			sata_phy0: sata-phy at a2000 {
> +				compatible = "marvell,mvebu-sata-phy";
> +				reg = <0xa2000 0x0334>;
> +				clocks = <&gate_clk 3>;
> +				clock-names = "sata";
> +				#phy-cells = <0>;
> +				status = "ok";
> +			};
> +
>  			rtc: real-time-clock at d8500 {
>  				compatible = "marvell,orion-rtc";
>  				reg = <0xd8500 0x20>;
> diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
> index 650ef30e1856..18400e74e0de 100644
> --- a/arch/arm/boot/dts/kirkwood-6281.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
> @@ -89,6 +89,8 @@
>  			interrupts = <21>;
>  			clocks = <&gate_clk 14>, <&gate_clk 15>;
>  			clock-names = "0", "1";
> +			phys = <&sata_phy0>, <&sata_phy1>;
> +			phy-names = "port0", "port1";
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
> index 3933a331ddc2..69c622bbbfb5 100644
> --- a/arch/arm/boot/dts/kirkwood-6282.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
> @@ -117,6 +117,8 @@
>  			interrupts = <21>;
>  			clocks = <&gate_clk 14>, <&gate_clk 15>;
>  			clock-names = "0", "1";
> +			phys = <&sata_phy0>, <&sata_phy1>;
> +			phy-names = "port0", "port1";
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 8b73c80f1dad..ee06951721c4 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -282,5 +282,23 @@
>  				/* set phy-handle property in board file */
>  			};
>  		};
> +
> +		sata_phy0: sata-phy at 82000 {
> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x82000 0x0334>;
> +			clocks = <&gate_clk 14>;
> +			clock-names = "sata";
> +			#phy-cells = <0>;
> +			status = "ok";
> +		};
> +
> +		sata_phy1: sata-phy at 84000 {
> +			compatible = "marvell,mvebu-sata-phy";
> +			reg = <0x84000 0x0334>;
> +			clocks = <&gate_clk 15>;
> +			clock-names = "sata";
> +			#phy-cells = <0>;
> +			status = "ok";
> +		};
>  	};
>  };
> 
