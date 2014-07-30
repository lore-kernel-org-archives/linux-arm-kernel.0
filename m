From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 30 Jul 2014 19:18:28 +0400
Subject: [PATCH 2/4] ARM: dts: add rk3288 dwc2 controller support
In-Reply-To: <1406684075-18271-1-git-send-email-kever.yang@rock-chips.com>
References: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
 <1406684075-18271-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <53D90CC4.9070009@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/30/2014 05:34 AM, Kever Yang wrote:

> rk3288 has two kind of usb controller, this add the dwc2 controller
> for otg and host1.

> Controller can works with usb PHY default setting and Vbus on.

> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>   arch/arm/boot/dts/rk3288.dtsi |   20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index abc51f5..4309c4f 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -646,5 +646,25 @@
>   			clock-names = "baudclk", "apb_pclk";
>   			status = "disabled";
>   		};
> +
> +		usb_otg: dwc2 at ff580000 {

    The ePAPR standard [1] says:

The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model. If appropriate, the name should 
be one of the following choices:

[...]
    ? usb

> +			compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
> +					"snps,dwc2";
> +			reg = <0xff580000 0x40000>;
> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru HCLK_OTG0>;
> +			clock-names = "otg";
> +			status = "disabled";
> +		};
> +
> +		usb_host1: dwc2 at ff540000 {

    Same here.

WBR, Sergei
