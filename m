From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 22 Aug 2015 16:23:41 +0300
Subject: [PATCH v6 2/5] dt-bindings: Add a binding for Mediatek xHCI host
 controller
In-Reply-To: <1440207911-17666-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1440207911-17666-1-git-send-email-chunfeng.yun@mediatek.com>
 <1440207911-17666-3-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <55D877DD.3010400@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 8/22/2015 4:45 AM, Chunfeng Yun wrote:

> add a DT binding documentation of xHCI host controller for the
> MT8173 SoC from Mediatek.

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   .../devicetree/bindings/usb/mt8173-xhci.txt        | 52 ++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
>
> diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> new file mode 100644
> index 0000000..8e6e463
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> @@ -0,0 +1,52 @@
> +mt65XX xHCI

    The file is called mt8173-xhci.txt. Are you sure MT65xx should be here?

> +
> +The device node for Mediatek SOC usb3.0 host controller
> +
> +Required properties:
> + - compatible : should contain "mediatek,mt8173-xhci"
> + - reg : specifies physical base address and size of the registers,
> +	the first one for MAC, the second for IPPC
> + - interrupts : interrupt used by the controller
> + - power-domains : a phandle to USB power domain node to control usb's

    USB's -- be consistent, please.

> +	mtcmos
> + - vusb33-supply : regulator of usb avdd3.3v
> +
> + - clocks : a list of phandle + clock-specifier pairs, one for each
> +	entry in clock-names
> + - clock-names : must contain
> +	"sys_ck": for clock of xHCI MAC
> +	"wakeup_deb_p0": for usb wakeup debounce clock of port0
> +	"wakeup_deb_p0": for usb wakeup debounce clock of port1

    USB.

> +
> + - phys : a list of phandle + phy specifier pairs
> + - usb3-lpm-capable : supports USB3 LPM
> + - mediatek,syscon-wakeup : phandle to syscon used to access usb wakeup
> +	control register
> + - mediatek,wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup
> +	mode; others means don't enable wakeup source of usb

    "Others mean" and "USB".

[...]

MBR, Sergei
