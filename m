From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 31 Jul 2017 17:54:22 -0400
Subject: [PATCH v2 2/3] ARM: dts: NSP: Rearrage USB entries
In-Reply-To: <1501538063-32662-1-git-send-email-jon.mason@broadcom.com>
References: <1501538063-32662-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1501538063-32662-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rest of the DTSI file is in incrementing addresses, but the USB
OHCI/ECHI entries are out of sequence.  Move them to put them in the
proper place.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index c82313a677d9..9feb3689d191 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -302,6 +302,22 @@
 			#size-cells = <0>;
 		};
 
+		ehci0: usb at 2a000 {
+			compatible = "generic-ehci";
+			reg = <0x2a000 0x100>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		ohci0: usb at 2b000 {
+			compatible = "generic-ohci";
+			reg = <0x2b000 0x100>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		crypto at 2f000 {
 			compatible = "brcm,spum-nsp-crypto";
 			reg = <0x2f000 0x900>;
@@ -326,22 +342,6 @@
 			status = "disabled";
 		};
 
-		ehci0: usb at 2a000 {
-			compatible = "generic-ehci";
-			reg = <0x2a000 0x100>;
-			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			dma-coherent;
-			status = "disabled";
-		};
-
-		ohci0: usb at 2b000 {
-			compatible = "generic-ohci";
-			reg = <0x2b000 0x100>;
-			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			dma-coherent;
-			status = "disabled";
-		};
-
 		rng: rng at 33000 {
 			compatible = "brcm,bcm-nsp-rng";
 			reg = <0x33000 0x14>;
-- 
2.7.4
