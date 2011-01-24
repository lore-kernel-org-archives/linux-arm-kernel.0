From: ccross@android.com (Colin Cross)
Date: Sun, 23 Jan 2011 18:01:33 -0800
Subject: [PATCH v2 28/28] ARM: tegra: clock: Add forward reference to struct
	clk
In-Reply-To: <1295834493-5019-1-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
Message-ID: <1295834493-5019-29-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/include/mach/clk.h    |    2 ++
 arch/arm/mach-tegra/include/mach/clkdev.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/clk.h b/arch/arm/mach-tegra/include/mach/clk.h
index d772395..a217f68 100644
--- a/arch/arm/mach-tegra/include/mach/clk.h
+++ b/arch/arm/mach-tegra/include/mach/clk.h
@@ -20,6 +20,8 @@
 #ifndef __MACH_CLK_H
 #define __MACH_CLK_H
 
+struct clk;
+
 void tegra_periph_reset_deassert(struct clk *c);
 void tegra_periph_reset_assert(struct clk *c);
 
diff --git a/arch/arm/mach-tegra/include/mach/clkdev.h b/arch/arm/mach-tegra/include/mach/clkdev.h
index 412f5c6..66cd3f4 100644
--- a/arch/arm/mach-tegra/include/mach/clkdev.h
+++ b/arch/arm/mach-tegra/include/mach/clkdev.h
@@ -20,6 +20,8 @@
 #ifndef __MACH_CLKDEV_H
 #define __MACH_CLKDEV_H
 
+struct clk;
+
 static inline int __clk_get(struct clk *clk)
 {
 	return 1;
-- 
1.7.3.1
