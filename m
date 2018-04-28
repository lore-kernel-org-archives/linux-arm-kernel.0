From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sat, 28 Apr 2018 22:51:41 +0200
Subject: [PATCH 4/5] ARM: ep93xx: i2s: Add IRQ to platform device resources
In-Reply-To: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
References: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
Message-ID: <20180428205142.31921-5-alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to "EP93xx User?s Guide" it's called I2SINTR and has number 60.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index e70feec6fad5..48d6a9e01dc8 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -635,6 +635,7 @@ EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
  *************************************************************************/
 static struct resource ep93xx_i2s_resource[] = {
 	DEFINE_RES_MEM(EP93XX_I2S_PHYS_BASE, 0x100),
+	DEFINE_RES_IRQ(IRQ_EP93XX_SAI),
 };
 
 static struct platform_device ep93xx_i2s_device = {
-- 
2.16.2
