From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 27 Apr 2014 14:29:06 +0100
Subject: [PATCH 4/5] ARM: dove: add Dove PMU DT entries to dove.dtsi
In-Reply-To: <20140427132312.GC26756@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeP8k-0000Us-4w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 187fd46b7b5e..64773e96e7f6 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -367,6 +367,13 @@
 				status = "disabled";
 			};
 
+			pmu: power-management at d0000 {
+				compatible = "marvell,pmu";
+				reg = <0xd0000 0x8000>, <0xd8000 0x8000>;
+				interrupts = <33>;
+				#reset-cells = <1>;
+			};
+
 			thermal: thermal-diode at d001c {
 				compatible = "marvell,dove-thermal";
 				reg = <0xd001c 0x0c>, <0xd005c 0x08>;
-- 
1.8.3.1
