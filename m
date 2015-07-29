From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 29 Jul 2015 23:51:00 +0200
Subject: [PATCH 2/2] ARM: BCM5301X: Add profiling support
In-Reply-To: <1438206660-30718-1-git-send-email-hauke@hauke-m.de>
References: <1438206660-30718-1-git-send-email-hauke@hauke-m.de>
Message-ID: <1438206660-30718-2-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felix Fietkau <nbd@openwrt.org>

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 0bae982..6f50f67 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -85,6 +85,13 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts =
+			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.1.4
