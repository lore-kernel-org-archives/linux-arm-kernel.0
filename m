From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:10:43 +0200
Subject: [PATCH v4 03/26] ARM: pxa: magician: Print more specific error
 message for global GPIOs
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609ACD3.6030600@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print more specific error message for global GPIOs.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index c8fa379..29d8146 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -752,7 +752,7 @@ static void __init magician_init(void)
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(magician_pin_config));
 	err = gpio_request_array(ARRAY_AND_SIZE(magician_global_gpios));
 	if (err)
-		pr_err("magician: Failed to request GPIOs: %d\n", err);
+		pr_err("magician: Failed to request global GPIOs: %d\n", err);
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
-- 
1.7.12.1
