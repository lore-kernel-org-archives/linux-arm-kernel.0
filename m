From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  3 May 2016 15:29:52 +0900
Subject: [PATCH] reset: fix Kconfig menu to include reset drivers in sub-menu
Message-ID: <1462256992-31063-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In "make menuconfig", reset drivers are currently lined up together
with the reset sub-system menu, like this:

    -*- Reset Controller Support  ----
    < > Hi6220 Reset Driver

(It also means, the menu "Reset Controller Support" is always empty.)

"Hi6220 Reset Driver" should go into the sub-menu of the
"Reset Controller Support".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/Kconfig     | 4 ++++
 drivers/reset/sti/Kconfig | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index df37212..6a0b24b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -12,5 +12,9 @@ menuconfig RESET_CONTROLLER
 
 	  If unsure, say no.
 
+if RESET_CONTROLLER
+
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
+
+endif
diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
index f8c15a3..6131785 100644
--- a/drivers/reset/sti/Kconfig
+++ b/drivers/reset/sti/Kconfig
@@ -2,7 +2,6 @@ if ARCH_STI
 
 config STI_RESET_SYSCFG
 	bool
-	select RESET_CONTROLLER
 
 config STIH415_RESET
 	bool
-- 
1.9.1
