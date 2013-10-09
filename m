From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Oct 2013 18:30:11 -0500
Subject: [PATCH V6 12/15] ARM: dts: OMAP4: add clock nodes for CPU
In-Reply-To: <1381361414-8851-1-git-send-email-nm@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361414-8851-1-git-send-email-nm@ti.com>
Message-ID: <1381361414-8851-10-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP443x, OMAP446x and OMAP447x platforms use dpll_mpu clock.
Add same to common definition.

Cc: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 6be1f56..27f1f3a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -32,6 +32,11 @@
 			device_type = "cpu";
 			next-level-cache = <&L2>;
 			reg = <0x0>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
-- 
1.7.9.5
