From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 22:11:43 +0900
Subject: [PATCH 3/3] ARM: mach-shmobile: kzm9g: do not enable REGULATOR_DUMMY
 in defconfig
In-Reply-To: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
References: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360761103-17357-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't enable REGULATOR_DUMMY, it is only intended for development / testing.
There doesn't seem to be any value in setting it here and doing
so was an error on my part.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 670c3b6..6751c02 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -86,7 +86,6 @@ CONFIG_I2C_SH_MOBILE=y
 CONFIG_GPIO_PCF857X=y
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
-CONFIG_REGULATOR_DUMMY=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
1.7.10.4
