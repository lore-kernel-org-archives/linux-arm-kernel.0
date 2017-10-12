From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 12 Oct 2017 15:47:43 +0200
Subject: [PATCH] firmware: meson-sm: use generic compatible
Message-ID: <20171012134743.10625-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The meson secure monitor seems to be compatible with more SoCs than
initially thought. Let's use the most generic compatible he have in
DT instead of the gxbb specific one

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt | 4 ++--
 drivers/firmware/meson/meson_sm.c                             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
index c248cd44f727..13a7815ac2b9 100644
--- a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
+++ b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
@@ -4,12 +4,12 @@ In the Amlogic SoCs the Secure Monitor code is used to provide access to the
 NVMEM, enable JTAG, set USB boot, etc...
 
 Required properties for the secure monitor node:
-- compatible: Should be "amlogic,meson-gxbb-sm"
+- compatible: Should be "amlogic,meson-gx-sm"
 
 Example:
 
 	firmware {
 		sm: secure-monitor {
-			compatible = "amlogic,meson-gxbb-sm";
+			compatible = "amlogic,meson-gx-sm";
 		};
 	};
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index ff204421117b..c83f7be2b1f4 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -38,7 +38,7 @@ struct meson_sm_chip {
 	struct meson_sm_cmd cmd[];
 };
 
-struct meson_sm_chip gxbb_chip = {
+struct meson_sm_chip gx_chip = {
 	.shmem_size		= SZ_4K,
 	.cmd_shmem_in_base	= 0x82000020,
 	.cmd_shmem_out_base	= 0x82000021,
@@ -213,7 +213,7 @@ int meson_sm_call_write(void *buffer, unsigned int size, unsigned int cmd_index,
 EXPORT_SYMBOL(meson_sm_call_write);
 
 static const struct of_device_id meson_sm_ids[] = {
-	{ .compatible = "amlogic,meson-gxbb-sm", .data = &gxbb_chip },
+	{ .compatible = "amlogic,meson-gx-sm", .data = &gx_chip },
 	{ /* sentinel */ },
 };
 
-- 
2.13.6
