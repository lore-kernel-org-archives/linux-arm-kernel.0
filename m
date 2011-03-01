From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 1 Mar 2011 14:39:50 +0100
Subject: [PATCH] mach-ux500: activate fix for errata 753970
Message-ID: <1298986790-25548-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This applies errata fix 753970 for all ux500 platforms. All
current ASICs suffer from this. If the problem is resolved in
later ASICs, the errata selection can be pushed down to other
Kconfig options.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 247caa3..203b986 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -6,6 +6,7 @@ config UX500_SOC_COMMON
 	select ARM_GIC
 	select HAS_MTU
 	select NOMADIK_GPIO
+	select ARM_ERRATA_753970
 
 menu "Ux500 SoC"
 
-- 
1.7.3.2
