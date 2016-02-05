From: jonmason@broadcom.com (Jon Mason)
Date: Fri,  5 Feb 2016 17:43:23 -0500
Subject: [PATCH 4/5] ARM: dts: NSP: Add SP805 Support to DT
In-Reply-To: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
References: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1454712204-30419-5-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the ARM SP805 Watchdog timer to the Northstar Plus
device tree.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 415a0a6..0e8cb6e 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -203,6 +203,14 @@
 			clock-frequency = <100000>;
 		};
 
+		wdt at 39000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x39000 0x1000>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&iprocslow>, <&iprocslow>;
+			clock-names = "wdogclk", "apb_pclk";
+		};
+
 		lcpll0: lcpll0 at 3f100 {
 			#clock-cells = <1>;
 			compatible = "brcm,nsp-lcpll0";
-- 
1.9.1
