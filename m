From: fkan@apm.com (Feng Kan)
Date: Thu, 13 Nov 2014 16:19:55 -0800
Subject: [PATCH V2 1/7] arm64: dts: Add APM X-Gene USB DTS node
In-Reply-To: <1415924401-3013-1-git-send-email-fkan@apm.com>
References: <1415924401-3013-1-git-send-email-fkan@apm.com>
Message-ID: <1415924401-3013-2-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This parch adds the device tree nodes for APM X-Gnene USB host controller.
Since X-Gene SOC supports maximum 2 USB ports, 2 dts node are added.

Signed-off-by: Bao Truong <btruong@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 295c72d..6b4c577 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -587,6 +587,22 @@
 			phy-names = "sata-phy";
 		};
 
+		usb0: dwusb at 19000000 {
+			status = "disabled";
+			compatible = "xhci-platform";
+			reg =  <0x0 0x19000000 0x0 0x100000>;
+			interrupts = <0x0 0x89 0x4>;
+			dma-coherent;
+		};
+
+		usb1: dwusb at 19800000 {
+			status = "disabled";
+			compatible = "xhci-platform";
+			reg =  <0x0 0x19800000 0x0 0x100000>;
+			interrupts = <0x0 0x8a 0x4>;
+			dma-coherent;
+		};
+
 		rtc: rtc at 10510000 {
 			compatible = "apm,xgene-rtc";
 			reg = <0x0 0x10510000 0x0 0x400>;
-- 
1.9.1
