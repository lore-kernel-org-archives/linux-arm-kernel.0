From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 21 Feb 2017 16:49:29 +0100
Subject: [PATCH v2 2/5] ARM: davinci: board-da850-evm: add I2C ID for VPIF
In-Reply-To: <1487692172-11772-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487692172-11772-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487692172-11772-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@baylibre.com>

VPIF capture driver now has a way to specific I2C adapter ID (was
previously hard-coded.)  Use the new interface.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6f1e129..0b9ff2a 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1213,6 +1213,7 @@ static struct vpif_subdev_info da850_vpif_capture_sdev_info[] = {
 static struct vpif_capture_config da850_vpif_capture_config = {
 	.subdev_info = da850_vpif_capture_sdev_info,
 	.subdev_count = ARRAY_SIZE(da850_vpif_capture_sdev_info),
+	.i2c_adapter_id = 1,
 	.chan_config[0] = {
 		.inputs = da850_ch0_inputs,
 		.input_count = ARRAY_SIZE(da850_ch0_inputs),
-- 
2.9.3
