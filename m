From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 13:31:53 +0900
Subject: [PATCH 6/6] ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig
In-Reply-To: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370406713-26599-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

An AS3711 PMIC is used on kzm9g to supply CPU power and LCD backlight.
This patch enables it in board defconfig.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index f6e585b..1ad0280 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -84,9 +84,12 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_GPIO_PCF857X=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_AS3711=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_AS3711=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
+CONFIG_BACKLIGHT_AS3711=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_FB_SH_MOBILE_MERAM=y
-- 
1.8.2.1
