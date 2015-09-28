From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:42:23 +0200
Subject: [PATCH v4 26/26] ARM: pxa: magician: Move platform_add_devices() to
 the end of magician_init()
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609B43F.4070200@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves platform_add_devices() (standard declaration of devices)
outside of the platform specific device declarations. Moving to the end
of the magician_init() clarifies the source code (standard and specific
declaration are not mixed).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 8d3946d..3aba1c4 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -1099,8 +1099,6 @@ static void __init magician_init(void)
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 
-	platform_add_devices(ARRAY_AND_SIZE(devices));
-
 	pxa_set_ficp_info(&magician_ficp_info);
 	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
@@ -1137,6 +1135,8 @@ static void __init magician_init(void)
 
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
+
+	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-- 
1.7.12.1
