From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 19:33:49 +0300
Subject: [PATCHv7 17/21] ARM: OMAP4: TWL: enable high speed mode for PMIC
 communication
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Message-ID: <1348590833-12335-18-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new parameters, I2C can now be put to high speed mode for
better performance.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 611cb63..7ff9667 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -218,6 +218,7 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
 	.cmd_reg_addr		= OMAP4_VDD_CORE_SR_CMD_REG,
+	.i2c_high_speed		= true,
 	.i2c_pad_load		= 3,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
-- 
1.7.4.1
