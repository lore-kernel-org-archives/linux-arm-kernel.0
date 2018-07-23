From: pengbo.mu@nxp.com (Pengbo Mu)
Date: Mon, 23 Jul 2018 11:11:26 +0800
Subject: [PATCH v6 3/4] arm64: dts: dwc3: description of incr burst type
In-Reply-To: <1532315487-23137-1-git-send-email-pengbo.mu@nxp.com>
References: <1532315487-23137-1-git-send-email-pengbo.mu@nxp.com>
Message-ID: <1532315487-23137-3-git-send-email-pengbo.mu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description of 'snps,incr-burst-type-adjustment'

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
---
Changes in v1:
 - add description of 'snps,incr-burst-type-adjustment' property
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 7f13ebe..3e4c38b 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -96,6 +96,11 @@ Optional properties:
 			enable periodic ESS TX threshold.
 
  - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+ - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
+			register, undefined length INCR burst type enable and INCRx type.
+			When just one value, which means INCRX burst mode enabled. When
+			more than one value, which means undefined length INCR burst type
+			enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
 
  - in addition all properties from usb-xhci.txt from the current directory are
    supported as well
@@ -108,4 +113,5 @@ dwc3 at 4a030000 {
 	reg = <0x4a030000 0xcfff>;
 	interrupts = <0 92 4>
 	usb-phy = <&usb2_phy>, <&usb3,phy>;
+	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 };
-- 
2.7.4
