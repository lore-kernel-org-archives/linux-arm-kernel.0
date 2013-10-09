From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Oct 2013 18:30:14 -0500
Subject: [PATCH V6 15/15] ARM: dts: DRA7: add clock nodes for CPU
In-Reply-To: <1381361414-8851-1-git-send-email-nm@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361414-8851-1-git-send-email-nm@ti.com>
Message-ID: <1381361414-8851-13-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: J Keerthy <j-keerthy@ti.com>

DRA7 platforms use dpll_mpu_ck clock for CPU. Add same to common
definition.

Cc: Benoit Cousson <bcousson@baylibre.com>
[nm at ti.com: keep in sync with clock node changes]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 92cbe3b..e723b52 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -42,6 +42,11 @@
 				1000000	1060000
 				1176000	1160000
 				>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.7.9.5
