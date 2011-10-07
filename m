From: olof@lixom.net (Olof Johansson)
Date: Thu,  6 Oct 2011 19:54:12 -0700
Subject: [PATCH 02/14] ARM: tegra: fuse: use IO_ADDRESS
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1317956064-17650-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes:

arch/arm/mach-tegra/fuse.c:44:12: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-tegra/fuse.c:44:12:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-tegra/fuse.c:44:12:    got unsigned int

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/fuse.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index 1fa26d9..8c590a8 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -31,19 +31,19 @@
 
 static inline u32 fuse_readl(unsigned long offset)
 {
-	return readl(IO_TO_VIRT(TEGRA_FUSE_BASE + offset));
+	return readl(IO_ADDRESS(TEGRA_FUSE_BASE + offset));
 }
 
 static inline void fuse_writel(u32 value, unsigned long offset)
 {
-	writel(value, IO_TO_VIRT(TEGRA_FUSE_BASE + offset));
+	writel(value, IO_ADDRESS(TEGRA_FUSE_BASE + offset));
 }
 
 void tegra_init_fuse(void)
 {
-	u32 reg = readl(IO_TO_VIRT(TEGRA_CLK_RESET_BASE + 0x48));
+	u32 reg = readl(IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x48));
 	reg |= 1 << 28;
-	writel(reg, IO_TO_VIRT(TEGRA_CLK_RESET_BASE + 0x48));
+	writel(reg, IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x48));
 
 	pr_info("Tegra SKU: %d CPU Process: %d Core Process: %d\n",
 		tegra_sku_id(), tegra_cpu_process_id(),
-- 
1.7.4.1
