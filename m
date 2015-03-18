From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 18 Mar 2015 18:36:40 +0200
Subject: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie phy
In-Reply-To: <1424422274-27946-2-git-send-email-kishon@ti.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
 <1424422274-27946-2-git-send-email-kishon@ti.com>
Message-ID: <5509A998.2080509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

As I can see Patch 1 from this series was merged in 4.0-rc4,
but this patch wasn't. As result, I can see below warning all the time during boot now:

[    0.594591] platform 4a094000.pciephy: Cannot lookup hwmod 'pcie1-phy'
 

On 02/20/2015 10:51 AM, Kishon Vijay Abraham I wrote:
> Now that we don't have hwmod entry for pcie PHY remove the
> ti,hwmod property from PCIE PHY's
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi |    2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 5827fed..18a904d 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1111,7 +1111,6 @@
>   					      "wkupclk", "refclk",
>   					      "div-clk", "phy-div";
>   				#phy-cells = <0>;
> -				ti,hwmods = "pcie1-phy";
>   			};
>   
>   			pcie2_phy: pciephy at 4a095000 {
> @@ -1130,7 +1129,6 @@
>   					      "wkupclk", "refclk",
>   					      "div-clk", "phy-div";
>   				#phy-cells = <0>;
> -				ti,hwmods = "pcie2-phy";
>   				status = "disabled";
>   			};
>   		};
> 
