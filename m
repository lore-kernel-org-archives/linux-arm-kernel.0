From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu, 24 Sep 2015 13:39:19 +0200
Subject: [PATCH v2 5/5] ARM: multi_v7_defconfig: Support RTC devices commonly
 used on Rockchip boards
In-Reply-To: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1443094759-28531-6-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the power management situation on Rockchip boards, there are
two common RTC setups. For boards using the RK808 chip as a PMIC that
chip also serves as the RTC, while boards using the ACT8846 typically use
the Haoyu Microelectronics HYM8563 chip as their RTC.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

Changes in v2:
- New patch, enable common RTC drivers

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2ce0d63..565a343 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -575,8 +575,10 @@ CONFIG_EDAC_HIGHBANK_L2=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX77686=y
+CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_MAX77802=m
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_PALMAS=y
-- 
2.5.3
