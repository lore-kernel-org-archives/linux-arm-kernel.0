From: khilman@baylibre.com (Kevin Hilman)
Date: Mon,  9 Jan 2017 12:55:31 -0800
Subject: [PATCH v2 6/6] ARM: davinci: board-da850-evm: add I2C ID for VPIF
In-Reply-To: <20170109205531.3435-1-khilman@baylibre.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
Message-ID: <20170109205531.3435-7-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VPIF capture driver now has a way to specific I2C adapter ID (was
previously hard-coded.)  Use the new interface.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index aac3ab1a044f..e5d4ded38d12 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1212,6 +1212,7 @@ static struct vpif_subdev_info da850_vpif_capture_sdev_info[] = {
 static struct vpif_capture_config da850_vpif_capture_config = {
 	.subdev_info = da850_vpif_capture_sdev_info,
 	.subdev_count = ARRAY_SIZE(da850_vpif_capture_sdev_info),
+	.i2c_adapter_id = 1,
 	.chan_config[0] = {
 		.inputs = da850_ch0_inputs,
 		.input_count = ARRAY_SIZE(da850_ch0_inputs),
-- 
2.9.3
