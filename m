From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 18 Apr 2014 13:23:20 +0200
Subject: [PATCH 5/8] ARM: mvebu: Add Device Tree description of xHCI hosts
 on Armada 38x
In-Reply-To: <1397816563-9000-6-git-send-email-gregory.clement@free-electrons.com>
References: <1397816563-9000-1-git-send-email-gregory.clement@free-electrons.com>
 <1397816563-9000-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <53510B28.1070709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2014 12:22 PM, Gregory CLEMENT wrote:
> The Marvell Armada 38x SoCs contain two xHCI host. This commit adds
> the Device Tree description of those interfaces at the SoC level, and
> also enables the two USB3 ports on the Armada 385 DB platform and one
> USB3 port on the Armada 385 RD platforms.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-385-db.dts |  8 ++++++++
>  arch/arm/boot/dts/armada-385-rd.dts |  4 ++++
>  arch/arm/boot/dts/armada-38x.dtsi   | 17 +++++++++++++++++
>  3 files changed, 29 insertions(+)
[...]
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index a064f59da02d..4f117e66aa1a 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -355,6 +355,23 @@
>  				clocks = <&coredivclk 0>;
>  				status = "disabled";
>  			};
> +
> +			usb3 at f0000 {
> +				compatible = "marvell,xhci-armada-380";
> +				reg = <0xf0000 0x3fff>,<0xf4000 0x3fff>;
> +				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gateclk 9>;

Using generic PHY framework will allow you to reference the PHY nodes
with "usb-phy" here.

BTW, you added a "marvell,armada-380-usb-utmi" in the patch for PHY init
but I can see no corresponding node added.

Sebastian

> +				status = "disabled";
> +			};
> +
> +			usb3 at f8000 {
> +				compatible = "marvell,xhci-armada-380";
> +				reg = <0xf8000 0x3fff>,<0xfc000 0x3fff>;
> +				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gateclk 10>;
> +				status = "disabled";
> +			};
> +
>  		};
>  	};
>  
> 
