From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  5 Sep 2017 01:16:02 +0200
Subject: [PATCH v2 3/3] arm64: dts: realtek: Add watchdog node for RTD1295
In-Reply-To: <20170904231602.29787-1-afaerber@suse.de>
References: <20170904231602.29787-1-afaerber@suse.de>
Message-ID: <20170904231602.29787-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the watchdog node to the RTD1295 Device Tree.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Depends on the pending clock nodes patch.
 
 v1 -> v2: Unchanged
 
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index fbbd6456079e..f39ab63f879d 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -123,6 +123,12 @@
 			#interrupt-cells = <1>;
 		};
 
+		watchdog at 98007680 {
+			compatible = "realtek,rtd1295-watchdog";
+			reg = <0x98007680 0x100>;
+			clocks = <&osc27M>;
+		};
+
 		uart0: serial at 98007800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x98007800 0x400>;
-- 
2.13.5
