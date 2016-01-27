From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 27 Jan 2016 12:27:51 +0800
Subject: [PATCH 14/15] Revert "bus: uniphier: allow only built-in driver"
In-Reply-To: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1453868872-26300-15-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 326ea45aa827da6686c78b5907f9839f91ef5782.

After covering to use helper of_platform_default_populate() to
populate the default bus, no error in build uniphier driver as
a module.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 129d47b..9a92c07 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -132,7 +132,7 @@ config SUNXI_RSB
 	  and AC100/AC200 ICs.
 
 config UNIPHIER_SYSTEM_BUS
-	bool "UniPhier System Bus driver"
+	tristate "UniPhier System Bus driver"
 	depends on ARCH_UNIPHIER && OF
 	default y
 	help
-- 
2.6.0.GIT
