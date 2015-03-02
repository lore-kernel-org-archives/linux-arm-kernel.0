From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 2 Mar 2015 15:23:54 +0800
Subject: [PATCH 2/2] gpio: dwapb: re-enable GPIO_DWAPB for arm64
Message-ID: <1425281034-3324-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hisilicon arm64 soc uses designWare gpio, re-enable it after
commit 1972c97db5b(gpio: dwapb: fix compile errors).

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index c1e2ca3..7ca0de3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -148,7 +148,7 @@ config GPIO_GENERIC_PLATFORM
 
 config GPIO_DWAPB
 	tristate "Synopsys DesignWare APB GPIO driver"
-	depends on ARM
+	depends on ARM || ARM64
 	depends on OF_GPIO
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
-- 
1.7.12.4
