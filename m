From: george.cherian@ti.com (George Cherian)
Date: Tue, 25 Nov 2014 18:41:54 +0530
Subject: [PATCH 18/19] arm: dts: exynos5250: Add named interrupt property for
 dwc3
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Message-ID: <1416921115-10467-19-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt names so that the same can be used for OTG easily.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index f21b9aa..c74cd8b 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -558,7 +558,12 @@
 		dwc3 {
 			compatible = "synopsys,dwc3";
 			reg = <0x12000000 0x10000>;
-			interrupts = <0 72 0>;
+			interrupts = <0 72 0>,
+				     <0 72 0>,
+				     <0 72 0>;
+			interrupt-names = "peripheral",
+					  "host",
+					  "otg";
 			phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
 			phy-names = "usb2-phy", "usb3-phy";
 		};
-- 
1.8.3.1
