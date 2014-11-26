From: cernekee@gmail.com (Kevin Cernekee)
Date: Tue, 25 Nov 2014 16:49:46 -0800
Subject: [PATCH 1/9] power/reset: brcmstb: Make the driver buildable on MIPS
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Message-ID: <1416962994-27095-2-git-send-email-cernekee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the driver doesn't use any ARM-specific headers, it is safe
to build on MIPS or with COMPILE_TEST.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/power/reset/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f65ff49..0379846 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -39,14 +39,13 @@ config POWER_RESET_AXXIA
 	  Say Y if you have an Axxia family SoC.
 
 config POWER_RESET_BRCMSTB
-	bool "Broadcom STB reset driver" if COMPILE_TEST
-	depends on ARM
+	bool "Broadcom STB reset driver"
+	depends on ARM || MIPS || COMPILE_TEST
 	default ARCH_BRCMSTB
 	help
-	  This driver provides restart support for ARM-based Broadcom STB
-	  boards.
+	  This driver provides restart support for Broadcom STB boards.
 
-	  Say Y here if you have an ARM-based Broadcom STB board and you wish
+	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
 config POWER_RESET_GPIO
-- 
2.1.0
