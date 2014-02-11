From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Feb 2014 17:10:32 +0000
Subject: [PATCH 08/12] mfd: vexpress-sysreg: Add syscon labels as platform data
In-Reply-To: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1392138636-29240-9-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds label names for syscon registers as platform
data for the relevant MFD cells.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mfd/vexpress-sysreg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index ece5ac8..57c21a0 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -132,6 +132,8 @@ void __init vexpress_sysreg_early_init(void __iomem *base)
 
 /* The sysreg block is just a random collection of various functions... */
 
+static const char vexpress_sysreg_sys_id_pdata[] = "sys_id";
+
 static struct bgpio_pdata vexpress_sysreg_sys_led_pdata = {
 	.label = "sys_led",
 	.base = -1,
@@ -150,6 +152,10 @@ static struct bgpio_pdata vexpress_sysreg_sys_flash_pdata = {
 	.ngpio = 1,
 };
 
+static const char vexpress_sysreg_sys_misc_pdata[] = "sys_misc";
+
+static const char vexpress_sysreg_sys_procid_pdata[] = "sys_procid";
+
 static struct mfd_cell vexpress_sysreg_cells[] = {
 	{
 		.name = "syscon",
@@ -157,6 +163,8 @@ static struct mfd_cell vexpress_sysreg_cells[] = {
 		.resources = (struct resource []) {
 			DEFINE_RES_MEM(SYS_ID, 0x4),
 		},
+		.platform_data = &vexpress_sysreg_sys_id_pdata,
+		.pdata_size = sizeof(vexpress_sysreg_sys_id_pdata),
 	}, {
 		.name = "basic-mmio-gpio",
 		.of_compatible = "arm,vexpress-sysreg,sys_led",
@@ -190,12 +198,16 @@ static struct mfd_cell vexpress_sysreg_cells[] = {
 		.resources = (struct resource []) {
 			DEFINE_RES_MEM(SYS_MISC, 0x4),
 		},
+		.platform_data = &vexpress_sysreg_sys_misc_pdata,
+		.pdata_size = sizeof(vexpress_sysreg_sys_misc_pdata),
 	}, {
 		.name = "syscon",
 		.num_resources = 1,
 		.resources = (struct resource []) {
 			DEFINE_RES_MEM(SYS_PROCID0, 0x8),
 		},
+		.platform_data = &vexpress_sysreg_sys_procid_pdata,
+		.pdata_size = sizeof(vexpress_sysreg_sys_procid_pdata),
 	}, {
 		.name = "vexpress-syscfg",
 		.num_resources = 1,
-- 
1.8.3.2
