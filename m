From: carlo@caione.org (Carlo Caione)
Date: Tue,  1 Dec 2015 17:24:22 +0100
Subject: [PATCH v3 6/6] ARM: meson: DTS: Enable GPIO IRQs
In-Reply-To: <1448987062-31225-1-git-send-email-carlo@caione.org>
References: <1448987062-31225-1-git-send-email-carlo@caione.org>
Message-ID: <1448987062-31225-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ee352bf..dd7ccd3 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -152,6 +152,11 @@
 		pinctrl: pinctrl at c1109880 {
 			compatible = "amlogic,meson8b-pinctrl";
 			reg = <0xc1109880 0x10>;
+			reg-names = "irq";
+			interrupt-parent = <&gic>;
+			amlogic,irqs-gpio = <64 65 66 67 68 69 70 71>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.5.0
