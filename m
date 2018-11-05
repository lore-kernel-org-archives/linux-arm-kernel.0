From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Nov 2018 10:19:32 +0100
Subject: [PATCH 02/14] dt-bindings: phy-pxa-usb: add bindings
In-Reply-To: <20180822204307.13251-3-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-3-lkundrak@v3.sk>
Message-ID: <20181105091932.GF4439@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-08-22 22:42:55, Lubomir Rintel wrote:
> This is the PHY chip for USB OTG on PXA platforms.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/phy/phy-pxa-usb.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
> new file mode 100644
> index 000000000000..5b12ab44c9e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
> @@ -0,0 +1,17 @@
> +Marvell PXA USB PHY
> +-------------------
> +
> +Required properties:
> +- compatible: one of: "marvell,mmp2-usb-phy", "marvell,pxa910-usb-phy",
> +	"marvell,pxa168-usb-phy",
> +- #phy-cells: must be 0
> +
> +Example:
> +	usb-phy: usbphy at d4207000 {
> +		compatible = "marvell,mmp2-usb-phy";
> +		reg = <0xd4207000 0x40>;
> +		#phy-cells = <0>;
> +		status = "okay";
> +	};
> +This document explains only the device tree data binding. For general
> +information about PHY subsystem refer to Documentation/phy.txt

Add empty space between last paragraph?

Delete "only" and "data"?

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/1100b3ac/attachment.sig>
