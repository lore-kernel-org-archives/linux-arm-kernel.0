From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 29 May 2015 11:21:39 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Make media support modular
In-Reply-To: <1432891299-22892-1-git-send-email-geert@linux-m68k.org>
References: <1432891299-22892-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1432891299-22892-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Make media support modular to reduce kernel size (-253 KiB):

       text    data     bss     dec     hex   filename
    12451039 1396476  339800 14187315  d87b33 vmlinux.before
    12202692 1387244  338456 13928392  d487c8 vmlinux.after

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Against next-20150528
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index dace65289bb75822..40ca1ab29a2e350f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -410,7 +410,7 @@ CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_VEXPRESS=y
-CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
-- 
1.9.1
