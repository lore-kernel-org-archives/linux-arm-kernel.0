From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 26 Mar 2010 15:43:30 +0530
Subject: [PATCH] removing compilation warning comming from <asm/irq.h>
Message-ID: <1269598410-15888-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq.h is using struct pt_regs *. Due to this compilation
warning is comming. Removing this warning by adding declaration
of struct pt_regs.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/irq.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 328f14a..567c398 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -3,6 +3,8 @@
 
 #include <mach/irqs.h>
 
+struct pt_regs;
+
 #ifndef irq_canonicalize
 #define irq_canonicalize(i)	(i)
 #endif
-- 
1.6.0.2
