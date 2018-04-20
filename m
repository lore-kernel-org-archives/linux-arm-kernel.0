From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 20 Apr 2018 17:54:41 +0200
Subject: [PATCH 2/5] ARM: dts: stih407-pinctrl: Fix complain about
 IRQ_TYPE_NONE usage
In-Reply-To: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
References: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1524239684-25463-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 53c6888d1fc0..e393519fb84c 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -52,7 +52,7 @@
 			st,syscfg = <&syscfg_sbc>;
 			reg = <0x0961f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 188 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09610000 0x6000>;
 
@@ -376,7 +376,7 @@
 			st,syscfg = <&syscfg_front>;
 			reg = <0x0920f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 189 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09200000 0x10000>;
 
@@ -936,7 +936,7 @@
 			st,syscfg = <&syscfg_front>;
 			reg = <0x0921f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09210000 0x10000>;
 
@@ -969,7 +969,7 @@
 			st,syscfg = <&syscfg_rear>;
 			reg = <0x0922f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 191 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09220000 0x6000>;
 
@@ -1164,7 +1164,7 @@
 			st,syscfg = <&syscfg_flash>;
 			reg = <0x0923f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 192 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09230000 0x3000>;
 
-- 
1.9.1
