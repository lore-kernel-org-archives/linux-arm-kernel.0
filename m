From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 17 May 2017 19:13:51 +0200
Subject: [PATCH v4 4/5] edb93xx: Add ADC platform device
In-Reply-To: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
References: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
Message-ID: <20170517171352.20369-5-alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the creation of ADC platform device on EDB93xx series of Cirrus
Logic evaluation boards. The driver for this device must be enabled separately,
either as built-in, or a module.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/edb93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 0ac176386789..7a7f280b07d7 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -245,6 +245,7 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
 	edb93xx_register_ide();
+	ep93xx_register_adc();
 }
 
 
-- 
2.12.2
