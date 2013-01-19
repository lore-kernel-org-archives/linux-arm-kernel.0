From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 19 Jan 2013 19:27:56 -0300
Subject: [PATCH v2 2/3] arm: omap2: gpmc-onenand: drop __init annotation
In-Reply-To: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1358634477-25868-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc_onenand_init() will be called from another driver's probe() function,
so drop the __init annotation, in order to prevent section mismatches.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 94a349e..fadd8743 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -356,7 +356,7 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 	return ret;
 }
 
-void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
+void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 {
 	int err;
 
-- 
1.7.8.6
