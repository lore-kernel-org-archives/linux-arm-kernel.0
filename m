From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Mar 2017 21:55:05 +0000
Subject: Applied "spi: loopback-test: fix compile error on x86" to the spi tree
In-Reply-To: <1489748878-15020-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <E1cozpx-0002AM-Pb@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: loopback-test: fix compile error on x86

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e542f7e63cb17242fcfc1be5edd69532cf434697 Mon Sep 17 00:00:00 2001
From: Frode Isaksen <fisaksen@baylibre.com>
Date: Fri, 17 Mar 2017 12:07:58 +0100
Subject: [PATCH] spi: loopback-test: fix compile error on x86

Fix compile error caused by missing vmalloc() definition
on x86 (and maybe other platforms) by including vmalloc.h.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 35960515382e..4e7843ec8aac 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/printk.h>
+#include <linux/vmalloc.h>
 #include <linux/spi/spi.h>
 
 #include "spi-test.h"
-- 
2.11.0
