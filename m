From: arend@broadcom.com (Arend van Spriel)
Date: Fri, 1 Nov 2013 21:54:10 +0100
Subject: [PATCH v2 7/9] phy: add Broadcom Kona USB2 PHY DT binding
In-Reply-To: <1383335158-19730-8-git-send-email-matt.porter@linaro.org>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
 <1383335158-19730-8-git-send-email-matt.porter@linaro.org>
Message-ID: <527414F2.7090402@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2013 08:45 PM, Matt Porter wrote:
> Add a binding that describes the Broadcom Kona USB2 PHY found
> on the BCM281xx family of SoCs.
>
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> ---
>   .../devicetree/bindings/phy/bcm-kona-usb2-phy.txt         | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
> new file mode 100644
> index 0000000..db309e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
> @@ -0,0 +1,15 @@
> +BROADCOM KONA USB2 PHY
> +
> +Required properties:
> + - compatible: brcm,kona-usb2-phy
> + - regs: offset and length of the PHY registers
> + - #phy-cells: must be 0
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +Example:
> +
> +	usbphy: usbphy at 3f130000 {
> +		compatible = "brcm,kona-usb2-phy";
> +		reg = <0x3f130000 0x28>;

I expect 'regs' iso 'reg' in this example.

Regards,
Arend

> +		#phy-cells = <0>;
> +	};
>
