From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 14 Jun 2018 18:41:47 +0200
Subject: [PATCH] ARM: dts: BCM53573: Add architected timer
Message-ID: <20180614164147.413-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

It's a standard ARM architected timer that was simply missed when
initially adding this .dtsi file.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm53573.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 16007d72c346..453a2a37dabd 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -48,6 +48,14 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.13.7
