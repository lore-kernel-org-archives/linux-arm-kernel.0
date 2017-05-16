From: s-anna@ti.com (Suman Anna)
Date: Tue, 16 May 2017 17:13:46 -0500
Subject: [PATCH 2/3] ARM: davinci: da8xx: Add names to DSP IOMEM resources
In-Reply-To: <20170516221347.37990-1-s-anna@ti.com>
References: <20170516221347.37990-1-s-anna@ti.com>
Message-ID: <20170516221347.37990-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add names to the IOMEM resources for the DSP device present on
DA8xx SoCs. This will facilitate the driver to use the names and
be agnostic of the resource order, and facilitate scalable DT
support in follow-up patches.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 1ccf52e49886..74c76538cda3 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -789,11 +789,13 @@ int __init da850_register_mmcsd1(struct davinci_mmc_config *config)
 
 static struct resource da8xx_rproc_resources[] = {
 	{ /* DSP boot address */
+		.name		= "host1cfg",
 		.start		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG,
 		.end		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG + 3,
 		.flags		= IORESOURCE_MEM,
 	},
 	{ /* DSP interrupt registers */
+		.name		= "chipsig",
 		.start		= DA8XX_SYSCFG0_BASE + DA8XX_CHIPSIG_REG,
 		.end		= DA8XX_SYSCFG0_BASE + DA8XX_CHIPSIG_REG + 7,
 		.flags		= IORESOURCE_MEM,
-- 
2.12.0
