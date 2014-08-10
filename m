From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 10 Aug 2014 14:21:49 +0200
Subject: [PATCH 1/6] ARM: mvebu: Add required ethernet muxing for the
 Armada 370 SoC
In-Reply-To: <1407511136-26477-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <53E763DD.4000305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2014 05:18 PM, Ezequiel Garcia wrote:
> This commit adds the required pin muxing for the two network interfaces
> and the MDIO interface, to the Armada 370 SoC.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 21b588b..b0700bf6 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -151,6 +151,25 @@
>  						       "mpp62", "mpp60", "mpp58";
>  					marvell,function = "audio";
>  				};
> +
> +				mdio_pins: mdio_pins {
> +					marvell,pins = "mpp17", "mpp18";
> +					marvell,function = "ge";
> +				};
> +
> +				ge0_pins: ge0_pins {

More nitpicking,

as stated by others it should be "ge{0,1]_rgmii_pins" not only because
it is rgmii, but because a370 also supports gmii for ge0.

Sebastian

> +					marvell,pins = "mpp5", "mpp6", "mpp7", "mpp8",
> +						       "mpp9", "mpp10", "mpp11", "mpp12",
> +						       "mpp13", "mpp14", "mpp15", "mpp16";
> +					marvell,function = "ge0";
> +				};
> +
> +				ge1_pins: ge1_pins {
> +					marvell,pins = "mpp19", "mpp20", "mpp21", "mpp22",
> +						       "mpp23", "mpp24", "mpp25", "mpp26",
> +						       "mpp27", "mpp28", "mpp29", "mpp30";
> +					marvell,function = "ge1";
> +				};
>  			};
>  
>  			gpio0: gpio at 18100 {
> 
