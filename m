From: rogerq@ti.com (Roger Quadros)
Date: Fri, 10 Jul 2015 11:31:03 +0300
Subject: [PATCH v2 2/5] dt-bindings: Add a binding for Mediatek xHCI host
 controller
In-Reply-To: <1436348468-4126-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1436348468-4126-1-git-send-email-chunfeng.yun@mediatek.com>
 <1436348468-4126-3-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <559F82C7.5010202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/07/15 12:41, Chunfeng Yun wrote:
> add a DT binding documentation of xHCI host controller for the
> MT8173 SoC from Mediatek.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mt8173-xhci.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> new file mode 100644
> index 0000000..94cec94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> @@ -0,0 +1,27 @@
> +MT65XX xhci
> +
> +The device node for Mediatek SOC usb3.0 host controller
> +
> +Required properties:
> + - compatible : supports "mediatek,mt8173-xhci"
> + - reg        : Offset and length of registers
> + - interrupts : Interrupt mode, number and trigger mode
> + - reg-vusb33-supply:  regulator of usb avdd3.3v
> + - reg-vbus-supply : regulator of vbus;

General trend is to use <supply-name>-supply.
We already know it is a regulator so no need to add "reg-"

So those two can be

vusb33-supply:
vbus-supply:


> + - usb-phy : the phy that xhci will bind
> + - usb3-lpm-capable: supports USB3 LPM
> + - clocks     : must support all clocks that xhci needs
> + - clock-names: should be "sys_mac" for sys and mac clocks
> +
> +Example:
> +usb: usb30 at 11270000 {
> +	compatible = "mediatek,mt8173-xhci";
> +	reg = <0 0x11270000 0 0x1000>;
> +	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
> +	reg-vusb33-supply = <&mt6397_vusb_reg>;
> +	reg-vbus-supply = <&usb_p1_vbus>;
> +	usb-phy = <&u3phy>;
> +	usb3-lpm-capable;
> +	clocks = <&topckgen CLK_TOP_USB30_SEL>;
> +	clock-names = "sys_mac";
> +};
> 

cheers,
-roger
