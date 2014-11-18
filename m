From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Nov 2014 12:07:03 -0600
Subject: [PATCH 05/10] arm: omap: omap2plus_defconfig: enable ECAP and EHRPWM
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Message-ID: <1416334028-7766-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many of AM335x and AM437x hook backlight to
one of these two devices. By enabling their
drivers we make sure pwm-backlight can do
its thing.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3837a3e..9be67b7 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -401,6 +401,8 @@ CONFIG_DMA_OMAP=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_PALMAS=y
 CONFIG_PWM=y
+CONFIG_PWM_TIECAP=y
+CONFIG_PWM_TIEHRPWM=y
 CONFIG_PWM_TWL=y
 CONFIG_PWM_TWL_LED=y
 CONFIG_OMAP_USB2=y
-- 
2.1.0.GIT
