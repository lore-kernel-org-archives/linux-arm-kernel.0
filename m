From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 15:33:33 +0530
Subject: [PATCH] removing compilation warning comming from clkdev.h
In-Reply-To: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
Message-ID: <1269511413-30621-2-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clkdev.h is using struct device *. Due to this compilation
warning is comming. Removing this warning.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/clkdev.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index 7a0690d..b56c138 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -13,6 +13,7 @@
 #define __ASM_CLKDEV_H
 
 struct clk;
+struct device;
 
 struct clk_lookup {
 	struct list_head	node;
-- 
1.6.0.2
