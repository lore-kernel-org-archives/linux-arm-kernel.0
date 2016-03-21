From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 21 Mar 2016 12:08:04 +0800
Subject: [PATCH] arm64: defconfig: fix override warning of MMC_BLOCK_MINORS
Message-ID: <1458533284-23010-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 2f85bb09d95e ("arm64: defconfig: Increase MMC_BLOCK_MINORS to
16") and commit 22b0898e831b ("arm64: add defconfig options for Allwinner
SoCs") both add MMC_BLOCK_MINORS to defconfig, which leads to override
warning, fix it.

Cc: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f705051..3ad26ff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -215,7 +215,6 @@ CONFIG_MMC_SPI=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
-CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_SYSCON=y
-- 
1.7.12.4
