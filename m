From: martin.vajnar@gmail.com (Martin Vajnar)
Date: Wed, 24 Dec 2014 00:27:57 +0100
Subject: [PATCH] hx4700: regulator: declare full constraints
Message-ID: <1419377277-12727-1-git-send-email-martin.vajnar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the removal of CONFIG_REGULATOR_DUMMY option, the touchscreen stopped
working. This patch enables the "replacement" for REGULATOR_DUMMY and
allows the touchscreen to work even though there is no regulator for "vcc".


Signed-off-by: Martin Vajnar <martin.vajnar@gmail.com>
---
 arch/arm/mach-pxa/hx4700.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index c66ad4e..5fb41ad 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -893,6 +893,8 @@ static void __init hx4700_init(void)
 	mdelay(10);
 	gpio_set_value(GPIO71_HX4700_ASIC3_nRESET, 1);
 	mdelay(10);
+
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(H4700, "HP iPAQ HX4700")
-- 
2.1.3
