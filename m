From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:41:30 +0530
Subject: [PATCH V4 02/62] sp810 Fix: Switch to slow mode before
	sysctl_soft_reset
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <1d7f323f40c3a6b55e7a321f762b7f8e8c4fac06.1295333957.git.viresh.kumar@st.com>
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
