From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 2 Nov 2015 13:40:58 -0500
Subject: [PATCH RESEND 3/3] ARM: dts: NSP: Add TWD Support to DT
In-Reply-To: <1446489658-29705-1-git-send-email-jonmason@broadcom.com>
References: <1446489658-29705-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1446489658-29705-4-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the ARM TWD Timer and Watchdog to the Northstar Plus
device tree.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 62bc86f..4bcdd28 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -80,6 +80,22 @@
 			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 		};
+
+		twd-timer at 19020600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x0600 0x20>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&periph_clk>;
+		};
+
+		twd-watchdog at 19020620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0x0620 0x20>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&periph_clk>;
+		};
 	};
 
 	clocks {
-- 
1.9.1
