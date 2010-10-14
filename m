From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 14 Oct 2010 08:38:04 -0700 (PDT)
Subject: [PATCH] eukrea_mbimxsd-baseboard: Pass the correct GPIO to gpio_free
Message-ID: <56183.25914.qm@web51002.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the correct GPIO to gpio_free

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

---
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 8869599..03380c3 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -267,7 +267,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 
 	gpio_request(GPIO_LCDPWR, "LCDPWR");
 	gpio_direction_output(GPIO_LCDPWR, 1);
-	gpio_free(GPIO_SWITCH1);
+	gpio_free(GPIO_LCDPWR);
 
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
-- 
1.6.0.4


      
