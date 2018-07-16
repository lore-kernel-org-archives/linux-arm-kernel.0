From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Jul 2018 15:36:50 +0200
Subject: [PATCH 6/7] arm64: dts: mt7622: use gpio-ranges to pinctrl device
In-Reply-To: <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
Message-ID: <76cde153-74db-101d-84a1-a0a7da679daf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/06/18 05:49, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Using gpio-ranges property represent which GPIOs correspond to which pins
> on MT7622 pin controllers. For details, we can see section 2.1 of
> Documentation/devicetree/bindings/gpio/gpio.txt to know how to bind pinctrl
> and gpio drivers via the "gpio-ranges" property.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

pushed now to v4.18-next/dts64

Thanks

> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index e2c5450..50cb56c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -291,6 +291,7 @@
>  		reg-names = "base", "eint";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		gpio-ranges = <&pio 0 0 103>;
>  		interrupt-controller;
>  		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
> 
