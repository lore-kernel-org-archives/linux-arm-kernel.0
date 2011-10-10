From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:27:53 -0700
Subject: [PATCH v2 03/14] ARM: tegra: tegra2_clocks: don't cast __iomem
	pointers
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a lot of:

arch/arm/mach-tegra/tegra2_clocks.c:180:2: warning: cast removes address space of expression
arch/arm/mach-tegra/tegra2_clocks.c:180:2: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-tegra/tegra2_clocks.c:180:2:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-tegra/tegra2_clocks.c:180:2:    got unsigned int
arch/arm/mach-tegra/tegra2_clocks.c:180:2: warning: cast removes address space of expression

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/tegra2_clocks.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 0fe9b3e..3325cd6 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -166,13 +166,13 @@ static DEFINE_SPINLOCK(clock_register_lock);
 static int tegra_periph_clk_enable_refcount[3 * 32];
 
 #define clk_writel(value, reg) \
-	__raw_writel(value, (u32)reg_clk_base + (reg))
+	__raw_writel(value, reg_clk_base + (reg))
 #define clk_readl(reg) \
-	__raw_readl((u32)reg_clk_base + (reg))
+	__raw_readl(reg_clk_base + (reg))
 #define pmc_writel(value, reg) \
-	__raw_writel(value, (u32)reg_pmc_base + (reg))
+	__raw_writel(value, reg_pmc_base + (reg))
 #define pmc_readl(reg) \
-	__raw_readl((u32)reg_pmc_base + (reg))
+	__raw_readl(reg_pmc_base + (reg))
 
 unsigned long clk_measure_input_freq(void)
 {
-- 
1.7.4.1
