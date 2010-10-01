From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:22 +0530
Subject: [PATCH V2 02/69] sp810 Fix: Switch to slow mode before
	sysctl_soft_reset
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <032611573f3f1738fc1496284850a6d8dbc84c16.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Before resetting system from system controller, switching to slow
mode is required.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/include/asm/hardware/sp810.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/sp810.h b/arch/arm/include/asm/hardware/sp810.h
index a101f10..6e3bafd 100644
--- a/arch/arm/include/asm/hardware/sp810.h
+++ b/arch/arm/include/asm/hardware/sp810.h
@@ -52,6 +52,9 @@
 
 static inline void sysctl_soft_reset(void __iomem *base)
 {
+	/* switch to slow mode */
+	writel(0x2, base + SCCTRL);
+
 	/* writing any value to SCSYSSTAT reg will reset system */
 	writel(0, base + SCSYSSTAT);
 }
-- 
1.7.2.2
