From: rogerq@ti.com (Roger Quadros)
Date: Wed, 5 Aug 2015 10:55:42 +0300
Subject: [PATCH 02/10] ARM: dts: dra7: Use "syscon-phy-power" instead
 of "ctrl-module" in SATA PHY node
In-Reply-To: <1438702233-8027-3-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
 <1438702233-8027-3-git-send-email-kishon@ti.com>
Message-ID: <55C1C17E.9050306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/15 18:30, Kishon Vijay Abraham I wrote:
> Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
> property from SATA PHY node. Since "omap_control_sata" note is no longer
> used, remove it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  arch/arm/boot/dts/dra7.dtsi |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 33c5655..6854385 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1115,14 +1115,6 @@
>  			status = "disabled";
>  		};
>  
> -		omap_control_sata: control-phy at 4a002374 {
> -			compatible = "ti,control-phy-pipe3";
> -			reg = <0x4a002374 0x4>;
> -			reg-names = "power";
> -			clocks = <&sys_clkin1>;
> -			clock-names = "sysclk";
> -		};
> -
>  		/* OCP2SCP3 */
>  		ocp2scp at 4a090000 {
>  			compatible = "ti,omap-ocp2scp";
> @@ -1137,7 +1129,7 @@
>  				      <0x4A096400 0x64>, /* phy_tx */
>  				      <0x4A096800 0x40>; /* pll_ctrl */
>  				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> -				ctrl-module = <&omap_control_sata>;
> +				syscon-phy-power = <&scm_conf 0x374>;
>  				clocks = <&sys_clkin1>, <&sata_ref_clk>;
>  				clock-names = "sysclk", "refclk";
>  				#phy-cells = <0>;
> 
