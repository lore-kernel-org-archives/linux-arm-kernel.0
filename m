From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 21 Oct 2016 23:01:05 +0900
Subject: [PATCH 6/7] ARM: dts: am335x: Add the power button interrupt
In-Reply-To: <20161021140106.21531-1-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
Message-ID: <20161021140106.21531-7-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the power button driver gets corresponding IRQ number by
using platform_get_irq().

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index cec9d91..0c0a90c 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -324,6 +324,11 @@
 		status = "okay";
 	};
 
+	pwrbutton {
+		interrupts = <TPS65217_IRQ_PB>;
+		status = "okay";
+	};
+
 	regulators {
 		dcdc1_reg: regulator at 0 {
 			regulator-name = "vdds_dpr";
-- 
2.9.3
