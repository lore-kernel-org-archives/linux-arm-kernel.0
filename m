From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Jul 2016 19:35:03 -0500
Subject: [PATCH v2 4/5] phy: DT binding documentation for qoriq usb 2.0 phy
In-Reply-To: <1468038656-10345-5-git-send-email-rajesh.bhagat@nxp.com>
References: <1468038656-10345-1-git-send-email-rajesh.bhagat@nxp.com>
 <1468038656-10345-5-git-send-email-rajesh.bhagat@nxp.com>
Message-ID: <20160716003503.GA6930@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 09, 2016 at 10:00:55AM +0530, Rajesh Bhagat wrote:
> Describes the qoriq usb 2.0 phy driver binding, currently used
> for LS1021A and LS1012A platform.
> 
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> ---
> Changes in v2:
>  - Adds DT binding documentation for qoriq usb 2.0 phy
>  - Changed the compatible string to fsl,qoriq-usb2-phy
> 
>  .../devicetree/bindings/phy/qoriq-usb2-phy.txt     | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qoriq-usb2-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qoriq-usb2-phy.txt b/Documentation/devicetree/bindings/phy/qoriq-usb2-phy.txt
> new file mode 100644
> index 0000000..f043855
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qoriq-usb2-phy.txt
> @@ -0,0 +1,22 @@
> +QorIQ SoC USB 2.0 PHY
> +
> +Required properties:
> + - compatible: should be "fsl,qoriq-usb2-phy",
> +   Wherever applicable, the version of the USB PHY should
> +   also be mentioned (for eg. fsl,qoriq-usb2-phy-vX.Y).
> +   where, X = Phy vendor(Legacy = 1, NXP = 2) and Y = PHY version

What does Legacy mean? FSL?

Use SoC specific compatible strings.

> + - reg : Address and length of the usb phy control register set.
> + - phy_type : For multi port host USB controllers, should be one of
> +   "ulpi", or "serial". For dual role USB controllers, should be
> +   one of "ulpi", "utmi", "utmi_wide", or "serial".
> +
> +The main purpose of this PHY driver is to enable the USB PHY reference clock
> +gate on the QorIQ SOC for USB2 PHY OR implement errata workaround in
> +future. Otherwise it is just an NOP PHY driver.
> +
> +usbphy0: usbphy at 8600000 {
> +        compatible = "fsl,qoriq-usb2-phy" "fsl,qoriq-usb2-phy-vX.Y";

most specific first.

> +        reg = <0x0 0x8600000 0x0 0x1000>;
> +        #phy-cells = <0>;
> +        phy_type = "ulpi";
> +};
