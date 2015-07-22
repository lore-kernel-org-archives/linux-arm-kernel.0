From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 22 Jul 2015 21:11:50 +0300
Subject: [PATCH v3 5/5] arm64: dts: mediatek: add xHCI & usb phy for mt8173
In-Reply-To: <1437573945-31586-6-git-send-email-chunfeng.yun@mediatek.com>
References: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>
 <1437573945-31586-6-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <55AFDCE6.2060608@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/22/2015 05:05 PM, Chunfeng Yun wrote:

> add xHCI and phy drivers for MT8173-EVB

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 15 ++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 31 +++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)

> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index f433c21..202b2b9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -13,6 +13,7 @@
>    */
>
>   /dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
>   #include "mt8173.dtsi"
>
>   / {
> @@ -32,6 +33,15 @@
>   	};
>
>   	chosen { };
> +
> +	usb_p1_vbus: fixedregulator at 0 {

    Just "regulator at 0" please. This is more in line with what ePAPR requires 
from the node names.

> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&pio 130 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>   };
>
>   &pwrap {
[...]
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 0696f8f..aa1ecc7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
[...]
> @@ -393,6 +394,36 @@
>   			#size-cells = <0>;
>   			status = "disabled";
>   		};
> +
> +		usb: usb30 at 11270000 {

    ePAPR standardizes the name "usb" for such nodes, please fix.

[...]

MBR, Sergei
