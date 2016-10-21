From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 21 Oct 2016 17:57:22 +0200
Subject: [PATCH 4/5] irqchip: st: remove STiH415/416 irqchip support
In-Reply-To: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
References: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1477065443-10668-5-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Support for STiH415/6 SoCs is being removed from the
kernel because the platforms are obsolete. This patch removes
the irqchip for these SoC's.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Cc: <tglx@linutronix.de>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-st.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 9af48a8..3ac9226 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -18,8 +18,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#define STIH415_SYSCFG_642		0x0a8
-#define STIH416_SYSCFG_7543		0x87c
 #define STIH407_SYSCFG_5102		0x198
 #define STID127_SYSCFG_734		0x088
 
@@ -48,14 +46,6 @@ struct st_irq_syscfg {
 
 static const struct of_device_id st_irq_syscfg_match[] = {
 	{
-		.compatible = "st,stih415-irq-syscfg",
-		.data = (void *)STIH415_SYSCFG_642,
-	},
-	{
-		.compatible = "st,stih416-irq-syscfg",
-		.data = (void *)STIH416_SYSCFG_7543,
-	},
-	{
 		.compatible = "st,stih407-irq-syscfg",
 		.data = (void *)STIH407_SYSCFG_5102,
 	},
-- 
1.9.1
