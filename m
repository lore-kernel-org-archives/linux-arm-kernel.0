From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Jan 2013 18:50:45 +0100
Subject: [PATCH 5/6] ARM: at91: rm9200: remake the BGA as default version
In-Reply-To: <cover.1358876553.git.nicolas.ferre@atmel.com>
References: <cover.1358876553.git.nicolas.ferre@atmel.com>
Message-ID: <548fb19ed30c1c0515a9b5604c3b3ffcdde14ed7.1358876553.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Make BGA as the default version as we are supposed to just have
to specify when we use the PQFP version.

Issue was existing since commit:
3e90772 (ARM: at91: fix at91rm9200 soc subtype handling).

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> [v3.3]
---
 arch/arm/mach-at91/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 9ee866c..4b67847 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -105,6 +105,8 @@ static void __init soc_detect(u32 dbgu_base)
 	switch (socid) {
 	case ARCH_ID_AT91RM9200:
 		at91_soc_initdata.type = AT91_SOC_RM9200;
+		if (at91_soc_initdata.subtype == AT91_SOC_SUBTYPE_NONE)
+			at91_soc_initdata.subtype = AT91_SOC_RM9200_BGA;
 		at91_boot_soc = at91rm9200_soc;
 		break;
 
-- 
1.8.0
