From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 17 Nov 2015 13:58:35 +0300
Subject: [PATCH v12 1/3] dt-bindings: Add a binding for Mediatek xHCI host
 controller
In-Reply-To: <1447751921-26746-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1447751921-26746-1-git-send-email-chunfeng.yun@mediatek.com>
 <1447751921-26746-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <564B085B.7060706@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/17/2015 12:18 PM, Chunfeng Yun wrote:

> add a DT binding documentation of xHCI host controller for the
> MT8173 SoC from Mediatek.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   .../devicetree/bindings/usb/mt8173-xhci.txt        | 51 ++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
>
> diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> new file mode 100644
> index 0000000..a78f20b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> @@ -0,0 +1,51 @@
> +MT8173 xHCI
> +
> +The device node for Mediatek SOC USB3.0 host controller
> +
> +Required properties:
> + - compatible : should contain "mediatek,mt8173-xhci"
> + - reg : specifies physical base address and size of the registers,
> +	the first one for MAC, the second for IPPC
> + - interrupts : interrupt used by the controller
> + - power-domains : a phandle to USB power domain node to control USB's
> +	mtcmos

    What's that?

> + - vusb33-supply : regulator of USB avdd3.3v
> +
> + - clocks : a list of phandle + clock-specifier pairs, one for each
> +	entry in clock-names
> + - clock-names : must contain
> +	"sys_ck": for clock of xHCI MAC
> +	"wakeup_deb_p0": for USB wakeup debounce clock of port0
> +	"wakeup_deb_p0": for USB wakeup debounce clock of port1

    "wakeup_deb_p1"?

> +
> + - phys : a list of phandle + phy specifier pairs
> +
> +Optional properties:
> + - mediatek,wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup
                                ^^ IP?

> +	mode;
> + - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
> +	control register, it depends on "mediatek,wakeup-src".
> + - vbus-supply : reference to the VBUS regulator;
> + - usb3-lpm-capable : supports USB3.0 LPM

[...]

MBR, Sergei
