From: tony@atomide.com (Tony Lindgren)
Date: Thu,  1 Mar 2018 14:16:58 -0800
Subject: [PATCH 04/10] ARM: omap2plus_defconfig: Update LIRC options
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Message-ID: <20180301221704.104530-5-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have LIRC selected as a loadable module but it must now be
built-in. Let's update that and add few interesting new options
for blinking IR LEDs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -320,13 +320,16 @@ CONFIG_REGULATOR_TPS65218=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_RC_CORE=m
+CONFIG_LIRC=y
 CONFIG_RC_DEVICES=y
+CONFIG_IR_SPI=m
 CONFIG_IR_RX51=m
+CONFIG_IR_GPIO_TX=m
+CONFIG_IR_PWM_TX=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
-CONFIG_LIRC=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_OMAP3=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
-- 
2.16.2
