From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  3 Mar 2015 11:43:17 +0100
Subject: [PATCH v2 4/7] ARM: mvebu: Enable Performance Monitor Unit on Armada
 XP/370 SoCs
In-Reply-To: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1425379400-4346-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and XP SoCs have Cortex-A9 compatible CPUs, and with a
Performance Monitoring Unit.

Enable it so that we can have hardware-assisted perf support.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 8a322ad57e5f..508ceb7c967a 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -73,6 +73,11 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts-extended = <&mpic 3>;
+	};
+
 	soc {
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
2.3.0
