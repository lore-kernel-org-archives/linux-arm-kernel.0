From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 15 Jul 2015 15:42:35 +0900
Subject: [PATCH] ARM: shmobile: Enable fixed voltage regulator in
 shmobile_defconfig
Message-ID: <1436942555-4851-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is selected by MACH_MARZEN which is enabled in shmobile_defconfig,
however, MACH_MARZEN is going away along with the board code it enables.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Tested on top of renesas-next-20150715-v4.2-rc1

This patch is intended to be queued up before the patch that removes
MACH_MARZEN, thus the wording above.
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 38f0da00114e..fc15a19bfaf0 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -120,6 +120,7 @@ CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_DA9063=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
-- 
2.1.4
