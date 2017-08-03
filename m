From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 14:08:38 -0500
Subject: [PATCH v2 4/6] dt-bindings: usb: Add documentation for NS2 IDM
 USB3
In-Reply-To: <1501109787-15489-5-git-send-email-jon.mason@broadcom.com>
References: <1501109787-15489-1-git-send-email-jon.mason@broadcom.com>
 <1501109787-15489-5-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170803190838.q4o7ijukgoliik5n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 06:56:25PM -0400, Jon Mason wrote:
> Add documentation for IDM USB3 registers available in NS2 SoC
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  Documentation/devicetree/bindings/usb/brcm,usb3-idm.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb3-idm.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/brcm,usb3-idm.txt b/Documentation/devicetree/bindings/usb/brcm,usb3-idm.txt
> new file mode 100644
> index 000000000000..3618dbcbe890
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/brcm,usb3-idm.txt
> @@ -0,0 +1,14 @@
> +Broadcom IDM USB3 registers
> +
> +Required properties:
> +- compatible: "brcm,usb3-idm"
> +- reg: Base address and length of the USB registers
> +
> +
> +Example:
> +
> +usb3_idm: idm at 67000000 {

I'm assuming these are all some misc registers in addition to the USB 
controller? If this is the USB controller itself, then use generic node 
names for the DT spec.

Acked-by: Rob Herring <robh@kernel.org>

> +        compatible = "brcm,usb3-idm";
> +        reg = <0x67000000 0x2000>;
> +};
> +
> -- 
> 2.7.4
> 
