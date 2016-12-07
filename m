From: khilman@baylibre.com (Kevin Hilman)
Date: Wed,  7 Dec 2016 11:31:37 -0800
Subject: [PATCH v2 4/4] ARM: davinci: board-da850-evm: add I2C ID for VPIF
In-Reply-To: <20161207193137.27947-1-khilman@baylibre.com>
References: <20161207193137.27947-1-khilman@baylibre.com>
Message-ID: <20161207193137.27947-5-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VPIF capture driver now has a way to specific I2C adapter ID (was
previously hard-coded.)  Use the new interface.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 8e4539f69fdc..60f15f276ab7 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1229,6 +1229,7 @@ static struct vpif_subdev_info da850_vpif_capture_sdev_info[] = {
 static struct vpif_capture_config da850_vpif_capture_config = {
 	.subdev_info = da850_vpif_capture_sdev_info,
 	.subdev_count = ARRAY_SIZE(da850_vpif_capture_sdev_info),
+	.i2c_adapter_id = 1,
 	.chan_config[0] = {
 		.inputs = da850_ch0_inputs,
 		.input_count = ARRAY_SIZE(da850_ch0_inputs),
-- 
2.9.3
