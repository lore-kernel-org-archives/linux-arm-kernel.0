From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sat, 31 Jan 2015 17:28:15 +0800
Subject: [PATCH] i2c: hix5hd2: add COMPILE_TEST
Message-ID: <1422696495-27282-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9439eb3ab9d1ec ("asm-generic: io: implement relaxed
accessor macros as conditional wrappers") has added
{read,write}{b,w,l,q}_relaxed to include/asm-generic/io.h.
So COMPILE_TEST can be added.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 31e8308ba899..ddf486389dc4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -79,7 +79,7 @@ config I2C_AMD8111
 
 config I2C_HIX5HD2
 	tristate "Hix5hd2 high-speed I2C driver"
-	depends on ARCH_HIX5HD2
+	depends on ARCH_HIX5HD2 || COMPILE_TEST
 	help
 	  Say Y here to include support for high-speed I2C controller in the
 	  Hisilicon based hix5hd2 SoCs.
-- 
1.9.1
