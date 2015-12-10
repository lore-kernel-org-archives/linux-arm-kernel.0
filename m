From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 10 Dec 2015 16:16:02 +0100
Subject: [PATCH 3/3] ARM: shmobile: defconfig: Enable frame buffer console for
 armadillo800eva
In-Reply-To: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
References: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449760562-26795-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling the frame buffer device on armadillo800eva requires the board
staging code.
Also enable the frame buffer, so you will actually see output during
boot.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
An alternative to CONFIG_FRAMEBUFFER_CONSOLE=y would be CONFIG_LOGO=y.
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 09a83d1411cc598b..969738324a5d5f81 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -153,6 +153,7 @@ CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
@@ -184,6 +185,8 @@ CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
 CONFIG_RENESAS_USB_DMAC=y
+CONFIG_STAGING=y
+CONFIG_STAGING_BOARD=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AK8975=y
-- 
1.9.1
