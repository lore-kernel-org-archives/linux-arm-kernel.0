From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 May 2015 12:51:50 +0200
Subject: [PATCH 2/2] ARM: ux500: enable CoreSight in defconfig
Message-ID: <1431514310-26110-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the CoreSight blocks found on the Ux500 SoC
into the Ux500 defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC people: plese apply this directly to the ARM SoC
tree in appropriate place.
---
 arch/arm/configs/u8500_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index b4c6d34ef946..07055eacbb0f 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -135,6 +135,10 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
+CONFIG_CORESIGHT=y
+CONFIG_CORESIGHT_SINK_TPIU=y
+CONFIG_CORESIGHT_SINK_ETBV10=y
+CONFIG_CORESIGHT_SOURCE_ETM3X=y
 CONFIG_CRYPTO_DEV_UX500=y
 CONFIG_CRYPTO_DEV_UX500_CRYP=y
 CONFIG_CRYPTO_DEV_UX500_HASH=y
-- 
1.9.3
