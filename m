From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Apr 2018 15:28:29 +0200
Subject: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
than the legacy ARCH_SHMOBILE, hence use the former.

This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/platform/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f9235e8f8e962d2e..7ad4725f9d1f9627 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -396,7 +396,7 @@ config VIDEO_SH_VEU
 config VIDEO_RENESAS_FDP1
 	tristate "Renesas Fine Display Processor"
 	depends on VIDEO_DEV && VIDEO_V4L2 && HAS_DMA
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on (!ARCH_RENESAS && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-- 
2.7.4
