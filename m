From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 31 May 2016 14:07:48 +0300
Subject: [PATCH v2,1/5] dt-bindings: mt8173-xhci: support host side of
 dual-role mode
In-Reply-To: <1464673962-11506-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1464673962-11506-1-git-send-email-chunfeng.yun@mediatek.com>
 <1464673962-11506-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <7828750b-f5ac-6fa0-ee6e-d4775c227e1a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 5/31/2016 8:52 AM, Chunfeng Yun wrote:

> Some resources, such as IPPC register etc, shared with device
> driver are moved into common glue layer when xHCI driver is the
> host side of dual-role mode and they should be changed as optional
> properties if they are required ones before. For clarity, add
> a new part of binding to support host side of dual-role mode.
>
> Additionally add optional properties of pinctrl for host only mode
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mt8173-xhci.txt        |   48 ++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> index b3a7ffa..542e3fa 100644
> --- a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> @@ -2,6 +2,14 @@ MT8173 xHCI
>
>  The device node for Mediatek SOC USB3.0 host controller
>
> +There are two scenarios: the first one only supports xHCI driver;
> +the second one supports dual-role mode, and the host is based on xHCI
> +driver. Take account of backward compatibility, we divide bindings
> +into two parts.
> +
> +1st: only supports xHCI driver
> +------------------------------------------------------------------------
> +
>  Required properties:
>   - compatible : should contain "mediatek,mt8173-xhci"
>   - reg : specifies physical base address and size of the registers,
> @@ -27,6 +35,9 @@ Optional properties:
>  	control register, it depends on "mediatek,wakeup-src".
>   - vbus-supply : reference to the VBUS regulator;
>   - usb3-lpm-capable : supports USB3.0 LPM
> + - pinctl-names : a pinctrl state named "default" must be defined

    pinctrl-names.

> + - pinctrl-0 : pin control group
> +	See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
>
>  Example:
>  usb30: usb at 11270000 {
[...]

MBR, Sergei
