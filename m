From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 20 Apr 2018 17:54:42 +0200
Subject: [PATCH 3/5] ARM: dts: stih407: Fix complain about IRQ_TYPE_NONE usage
In-Reply-To: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
References: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1524239684-25463-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 57efc87dec2b..5b7951ffc350 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -108,7 +108,7 @@
 				reg = <0x8d04000 0x1000>;
 				reg-names = "hdmi-reg";
 				#sound-dai-cells = <0>;
-				interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names	= "irq";
 				clock-names = "pix",
 					      "tmds",
-- 
1.9.1
