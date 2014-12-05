From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Fri,  5 Dec 2014 11:38:39 +0800
Subject: [PATCH v4 1/4] ARM: hip04: add GPIO configure in hisi_defconfig
In-Reply-To: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
References: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <1417750722-14027-2-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO controller of Hisilicon hip04 Soc uses the IP from Sysnopsis,
gpio-dwapb.c can be reused to support this GPIO controller. This patch
adds related configure items in hisi_defconfig.

Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
---
 arch/arm/configs/hisi_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 1772505..130292b 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -41,6 +41,9 @@ CONFIG_SPI_PL022=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_DWAPB=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_DRM=y
 CONFIG_FB_SIMPLE=y
 CONFIG_USB=y
-- 
1.7.9.5
