From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Dec 2015 14:24:54 +0900
Subject: [PATCH 4/7] ARM: shmobile: defconfig: Enable frame buffer console for
 armadillo800eva
In-Reply-To: <cover.1450315426.git.horms+renesas@verge.net.au>
References: <cover.1450315426.git.horms+renesas@verge.net.au>
Message-ID: <af48156ff3a1762989627fba7c56e77743fc0fdc.1450315426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enabling the frame buffer device on armadillo800eva requires the board
staging code.
Also enable the frame buffer, so you will actually see output during
boot.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d2259952879d..5bc4f537f9da 100644
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
2.1.4
