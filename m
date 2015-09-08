From: kwizart@gmail.com (Nicolas Chauvet)
Date: Tue,  8 Sep 2015 12:18:46 +0200
Subject: [PATCH 1/2] nouveau: arm: Add MODULE_FIRMWARE for gk20a
Message-ID: <1441707527-9890-1-git-send-email-kwizart@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is needed by initramfs tools to detect
the required firmware files for the module.

This patch tests for NOUVEAU_PLATFORM_DRIVER and either
TEGRA_124_SOC or TEGRA_132_SOC for the firmwares related to
the Tegra K1 generation.

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index ccefb64..862c225 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1111,3 +1111,14 @@ MODULE_DEVICE_TABLE(pci, nouveau_drm_pci_table);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL and additional rights");
+#if defined(CONFIG_NOUVEAU_PLATFORM_DRIVER) && \
+  (IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC) || IS_ENABLED(CONFIG_ARCH_TEGRA_132_SOC))
+MODULE_FIRMWARE("nvidia/gk20a/fecs_data.bin");
+MODULE_FIRMWARE("nvidia/gk20a/fecs_inst.bin");
+MODULE_FIRMWARE("nvidia/gk20a/gpccs_data.bin");
+MODULE_FIRMWARE("nvidia/gk20a/gpccs_inst.bin");
+MODULE_FIRMWARE("nvidia/gk20a/sw_bundle_init.bin");
+MODULE_FIRMWARE("nvidia/gk20a/sw_ctx.bin");
+MODULE_FIRMWARE("nvidia/gk20a/sw_method_init.bin");
+MODULE_FIRMWARE("nvidia/gk20a/sw_nonctx.bin");
+#endif
-- 
2.4.3
