From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Jul 2013 15:50:34 +0300
Subject: [PATCH v2 2/5] arm: omap5: dts: fix ocp2scp DTS data
In-Reply-To: <1373979037-27587-1-git-send-email-balbi@ti.com>
References: <1373979037-27587-1-git-send-email-balbi@ti.com>
Message-ID: <1373979037-27587-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fixes the DTS data for ocp2scp
node by adding the missing reg property.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5c99f19..4e41409 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -652,10 +652,11 @@
 			};
 		};
 
-		ocp2scp {
+		ocp2scp at 4a080000 {
 			compatible = "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
+			reg = <0x4a080000 0x20>;
 			ranges;
 			ti,hwmods = "ocp2scp1";
 			usb2_phy: usb2phy at 4a084000 {
-- 
1.8.3.3.754.g9c3c367
