From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:08:45 +0200
Subject: [PATCH 02/10] mtd: enable AFS selection for ARM64
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444914533-27782-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM use their special partitions also on the ARM64 architecture
reference designs, so enable this for ARM64.

Cc: Ryan Harkin <ryan.harkin@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index a03ad2951c7b..42cc953309f1 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -112,7 +112,7 @@ config MTD_CMDLINE_PARTS
 
 config MTD_AFS_PARTS
 	tristate "ARM Firmware Suite partition parsing"
-	depends on ARM
+	depends on (ARM || ARM64)
 	---help---
 	  The ARM Firmware Suite allows the user to divide flash devices into
 	  multiple 'images'. Each such image has a header containing its name
-- 
2.4.3
