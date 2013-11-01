From: matt.porter@linaro.org (Matt Porter)
Date: Fri, 1 Nov 2013 18:56:14 -0400
Subject: [PATCH v2 7/9] phy: add Broadcom Kona USB2 PHY DT binding
In-Reply-To: <527414F2.7090402@broadcom.com>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
 <1383335158-19730-8-git-send-email-matt.porter@linaro.org>
 <527414F2.7090402@broadcom.com>
Message-ID: <20131101225614.GC17505@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 09:54:10PM +0100, Arend van Spriel wrote:
> On 11/01/2013 08:45 PM, Matt Porter wrote:
> >Add a binding that describes the Broadcom Kona USB2 PHY found
> >on the BCM281xx family of SoCs.
> >
> >Signed-off-by: Matt Porter <matt.porter@linaro.org>
> >---
> >  .../devicetree/bindings/phy/bcm-kona-usb2-phy.txt         | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
> >
> >diff --git a/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
> >new file mode 100644
> >index 0000000..db309e2
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
> >@@ -0,0 +1,15 @@
> >+BROADCOM KONA USB2 PHY
> >+
> >+Required properties:
> >+ - compatible: brcm,kona-usb2-phy
> >+ - regs: offset and length of the PHY registers
> >+ - #phy-cells: must be 0
> >+Refer to phy/phy-bindings.txt for the generic PHY binding properties
> >+
> >+Example:
> >+
> >+	usbphy: usbphy at 3f130000 {
> >+		compatible = "brcm,kona-usb2-phy";
> >+		reg = <0x3f130000 0x28>;
> 
> I expect 'regs' iso 'reg' in this example.

Yes, will fix the typo in that property for v3.

Thanks,
Matt

> >+		#phy-cells = <0>;
> >+	};
> >
> 
> 
