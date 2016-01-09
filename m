From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sat,  9 Jan 2016 20:28:02 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Change RTC_DRV_HYM8563 to builtin
Message-ID: <1452367683-11160-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from providing an RTC the hym8563 chip on some rockchip boards
(e.g. rock2 square and firefly) also provide the 32khz clock used by the
SoCs thermal sensors.

Switch the driver from a module to builtin such that the thermal
protection can work even if modules aren't used/loaded.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f6e104d..0fcb1dd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -650,7 +650,7 @@ CONFIG_EDAC_HIGHBANK_L2=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
-CONFIG_RTC_DRV_HYM8563=m
+CONFIG_RTC_DRV_HYM8563=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX8997=m
 CONFIG_RTC_DRV_MAX77686=y
-- 
2.7.0.rc3
