From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Jun 2012 15:01:50 -0600
Subject: [PATCH] ARM: tegra: make tegra_cpu_reset_handler_enable() __init
Message-ID: <1340053310-20855-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This solves a section mismatch warning. I hadn't noticed this before,
because my compiler was inlining tegra_cpu_reset_handler_enable() inside
tegra_cpu_reset_handler_init(), which is already __init, but I switched
compilers and it stopped doing that.

Cc: <stable@kernel.org> # v3.4
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Arnd, Olof, do you want me to put this in a pull request, or can you apply
it directly for 3.5?

 arch/arm/mach-tegra/reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 4d6a2ee..5beb7eb 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -33,7 +33,7 @@
 
 static bool is_enabled;
 
-static void tegra_cpu_reset_handler_enable(void)
+static void __init tegra_cpu_reset_handler_enable(void)
 {
 	void __iomem *iram_base = IO_ADDRESS(TEGRA_IRAM_RESET_BASE);
 	void __iomem *evp_cpu_reset =
-- 
1.7.0.4
