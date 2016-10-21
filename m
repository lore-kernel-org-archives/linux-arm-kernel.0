From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 21 Oct 2016 17:57:23 +0200
Subject: [PATCH 5/5] irqchip: st: Remove obsolete platforms from dt binding doc
In-Reply-To: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
References: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1477065443-10668-6-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

STiH415/6 SoC support is being removed from the kernel.
This patch updates the sti irchip and removes
references to these obsolete platforms.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Cc: <tglx@linutronix.de>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
---
 .../devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt  | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
index ced6014..23d1e1c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
@@ -7,8 +7,6 @@ This driver is used to unmask them prior to use.
 
 Required properties:
 - compatible	: Should be set to one of:
-			"st,stih415-irq-syscfg"
-			"st,stih416-irq-syscfg"
 			"st,stih407-irq-syscfg"
 			"st,stid127-irq-syscfg"
 - st,syscfg	: Phandle to Cortex-A9 IRQ system config registers
@@ -25,8 +23,8 @@ Optional properties:
 Example:
 
 irq-syscfg {
-	compatible    = "st,stih416-irq-syscfg";
-	st,syscfg     = <&syscfg_cpu>;
+	compatible    = "st,stih407-irq-syscfg";
+	st,syscfg     = <&syscfg_core>;
 	st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
 			<ST_IRQ_SYSCFG_PMU_1>;
 	st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
-- 
1.9.1
