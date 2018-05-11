From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 May 2018 20:51:35 +0530
Subject: [PATCH 2/3] ARM: davinci: board-dm646x-evm: pass correct I2C adapter
 id for VPIF
In-Reply-To: <20180511152136.29515-1-nsekhar@ti.com>
References: <20180511152136.29515-1-nsekhar@ti.com>
Message-ID: <20180511152136.29515-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit a16cb91ad9c4 ("[media] media: vpif: use a configurable
i2c_adapter_id for vpif display") removed hardcoded I2C adaptor
setting in VPIF driver, but missed updating platform data passed
from DM646x board.

Fix it.

Fixes: a16cb91ad9c4 ("[media] media: vpif: use a configurable i2c_adapter_id for vpif display")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 37c9e0ee4dcc..bf6f85048d17 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -533,6 +533,7 @@ static struct vpif_display_config dm646x_vpif_display_config = {
 	.set_clock	= set_vpif_clock,
 	.subdevinfo	= dm646x_vpif_subdev,
 	.subdev_count	= ARRAY_SIZE(dm646x_vpif_subdev),
+	.i2c_adapter_id = 1,
 	.chan_config[0] = {
 		.outputs = dm6467_ch0_outputs,
 		.output_count = ARRAY_SIZE(dm6467_ch0_outputs),
@@ -675,6 +676,7 @@ static struct vpif_capture_config dm646x_vpif_capture_cfg = {
 	.setup_input_channel_mode = setup_vpif_input_channel_mode,
 	.subdev_info = vpif_capture_sdev_info,
 	.subdev_count = ARRAY_SIZE(vpif_capture_sdev_info),
+	.i2c_adapter_id = 1,
 	.chan_config[0] = {
 		.inputs = dm6467_ch0_inputs,
 		.input_count = ARRAY_SIZE(dm6467_ch0_inputs),
-- 
2.16.2
