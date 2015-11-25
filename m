From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 25 Nov 2015 12:50:47 +0100
Subject: [PATCH 4/5] edb93xx: Add ADC platform device
In-Reply-To: <56558B23.4080506@gmail.com>
References: <56558B23.4080506@gmail.com>
Message-ID: <5655A097.6000000@gmail.com>
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
index ad92d9f..8da0127 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -264,6 +264,7 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
 	edb93xx_register_ide();
+	ep93xx_register_adc();
 }
