From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  5 Sep 2013 19:39:02 +0200
Subject: [PATCH 3/6] RFC: block: drop dependency on ARCH_SHARK
Message-ID: <1378402742-16423-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this machine deleted, there is no need to maintain the
MFM block driver for its hard disk either.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
NOTE: Do not apply this patch other than after removing the
RFC tag. I am collecting ACKs from subsystem maintainers to
take this through ARM SoC if we continue with the deletion.
---
 drivers/block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index e07a5fd..e67fa16 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -505,7 +505,7 @@ config VIRTIO_BLK
 config BLK_DEV_HD
 	bool "Very old hard disk (MFM/RLL/IDE) driver"
 	depends on HAVE_IDE
-	depends on !ARM || ARCH_RPC || ARCH_SHARK || BROKEN
+	depends on !ARM || ARCH_RPC || BROKEN
 	help
 	  This is a very old hard disk driver that lacks the enhanced
 	  functionality of the newer ones.
-- 
1.8.3.1
