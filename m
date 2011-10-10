From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:27:58 -0700
Subject: [PATCH v2 08/14] ARM: tegra: tegra_init_cache should be static
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-9-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not exported and not used externally.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index d5e3f89..690b888 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -61,7 +61,7 @@ static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
-void __init tegra_init_cache(void)
+static void __init tegra_init_cache(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
-- 
1.7.4.1
