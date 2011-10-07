From: olof@lixom.net (Olof Johansson)
Date: Thu,  6 Oct 2011 19:54:13 -0700
Subject: [PATCH 03/14] ARM: tegra: pinmux: use IO_ADDRESS
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1317956064-17650-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes lots of:

arch/arm/mach-tegra/pinmux.c:175:9: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-tegra/pinmux.c:175:9:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-tegra/pinmux.c:175:9:    got unsigned lon

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/pinmux-t2-tables.c |    4 ++--
 arch/arm/mach-tegra/pinmux.c           |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/pinmux-t2-tables.c b/arch/arm/mach-tegra/pinmux-t2-tables.c
index a475367..94e2417 100644
--- a/arch/arm/mach-tegra/pinmux-t2-tables.c
+++ b/arch/arm/mach-tegra/pinmux-t2-tables.c
@@ -232,12 +232,12 @@ static u32 pinmux_reg[TRISTATE_REG_NUM + PIN_MUX_CTL_REG_NUM +
 
 static inline unsigned long pg_readl(unsigned long offset)
 {
-	return readl(IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+	return readl(IO_ADDRESS(TEGRA_APB_MISC_BASE + offset));
 }
 
 static inline void pg_writel(unsigned long value, unsigned long offset)
 {
-	writel(value, IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+	writel(value, IO_ADDRESS(TEGRA_APB_MISC_BASE + offset));
 }
 
 void tegra_pinmux_suspend(void)
diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
index f80d507..0a85e0e 100644
--- a/arch/arm/mach-tegra/pinmux.c
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -172,12 +172,12 @@ static const char *pupd_name(unsigned long val)
 
 static inline unsigned long pg_readl(unsigned long offset)
 {
-	return readl(IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+	return readl(IO_ADDRESS(TEGRA_APB_MISC_BASE + offset));
 }
 
 static inline void pg_writel(unsigned long value, unsigned long offset)
 {
-	writel(value, IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+	writel(value, IO_ADDRESS(TEGRA_APB_MISC_BASE + offset));
 }
 
 static int tegra_pinmux_set_func(const struct tegra_pingroup_config *config)
-- 
1.7.4.1
