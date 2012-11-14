From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 14 Nov 2012 11:19:33 -0200
Subject: [PATCH v2 1/2] ARM: mx27_3ds: Add VPU support
Message-ID: <1352899174-28022-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27 has a VPU (Video Processing Unit) block that allows doing H264/MPEG4
decoding and encoding in hardware.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Do not allocate the coda buffers explicetely

 arch/arm/mach-imx/mach-mx27_3ds.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index d0e547f..e37a114 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -531,6 +531,7 @@ static void __init mx27pdk_init(void)
 	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
 
 	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
+	imx27_add_coda();
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.7.9.5
