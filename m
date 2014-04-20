From: balbi@ti.com (Felipe Balbi)
Date: Sat, 19 Apr 2014 22:21:59 -0500
Subject: [PATCH 3/8] xhci-platform: Add a new controller using xhci:
 Armada 38x
In-Reply-To: <1397816563-9000-4-git-send-email-gregory.clement@free-electrons.com>
References: <1397816563-9000-1-git-send-email-gregory.clement@free-electrons.com>
 <1397816563-9000-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140420032159.GC26893@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 12:22:38PM +0200, Gregory CLEMENT wrote:
> Extend the compatible string list with xhci-armada-380. It is used to
> describe xhci controller which is in the Armada 38x SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index 90f8f607d125..c49c14037afe 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -1,7 +1,8 @@
>  USB xHCI controllers
>  
>  Required properties:
> -  - compatible: should be "generic-xhci" (deprecated: "xhci-platform").
> +  - compatible: should be on of "generic-xhci",

should be "one" of.

> +    "marvell,xhci-armada-380" (deprecated: "xhci-platform").

and this gives me a better idea, instead of using the quirk I suggested
before, match against this compatible:

	if (of_device_is_compatible(dev, "marvell,xhci-armada-380")
		xhci_marvel_mbus_init_quirk(dev);

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140419/df9bdecb/attachment.sig>
