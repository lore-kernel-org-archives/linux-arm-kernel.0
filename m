From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 20 Apr 2018 17:54:44 +0200
Subject: [PATCH 5/5] ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE
 usage
In-Reply-To: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
References: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1524239684-25463-6-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index c67edb1a8121..4dedfcb0fcb3 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -154,8 +154,8 @@
 			reg		= <0x08a20000 0x10000>,
 					  <0x08a00000 0x4000>;
 			reg-names	= "c8sectpfe", "c8sectpfe-ram";
-			interrupts	= <GIC_SPI 34 IRQ_TYPE_NONE>,
-					  <GIC_SPI 35 IRQ_TYPE_NONE>;
+			interrupts	= <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+					  <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names	= "c8sectpfe-error-irq",
 					  "c8sectpfe-idle-irq";
 			pinctrl-0	= <&pinctrl_tsin0_serial>;
-- 
1.9.1
