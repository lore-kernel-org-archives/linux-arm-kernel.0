From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 26 Mar 2010 16:09:28 +0530
Subject: [PATCH resend] removing compilation warning comming from <asm/irq.h>
Message-ID: <1269599968-32459-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq.h is using struct pt_regs *. Due to this compilation
warning is comming. Removing this warning by adding declaration
of struct pt_regs.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/irq.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 328f14a..237282f 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -17,6 +17,7 @@
 
 #ifndef __ASSEMBLY__
 struct irqaction;
+struct pt_regs;
 extern void migrate_irqs(void);
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
-- 
1.6.0.2
