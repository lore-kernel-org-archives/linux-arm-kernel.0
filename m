From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  2 Oct 2011 23:11:55 +0200
Subject: [PATCH] mach-integrator: remove VGA_CONSOLE from defconfig
Message-ID: <1317589915-31984-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After scratching my head for a while fighting strange boot delays
and hangs, I realized that the VGA_CONSOLE code is just poking
around in the PCI memory space at random. It really has no clue
whether there is a VGA card in the first slot or not, and it
doesn't in any way try to determine if there is one. It doesn't
belong in the defconfig, people with VGA cards in their
Integrators can reenable this and fix it properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 1103f62..f26460d 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -66,6 +66,7 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
 CONFIG_FB_MATROX_MYSTIQUE=y
+# CONFIG_VGA_CONSOLE is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL030=y
 CONFIG_EXT2_FS=y
-- 
1.7.6.2
