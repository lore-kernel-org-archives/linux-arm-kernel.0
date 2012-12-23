From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 23 Dec 2012 19:07:49 +0100
Subject: [PATCH] ARM: at91: rm9200: remake the BGA as default version
Message-ID: <1356286069-8852-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as we are supposed to just have to specify when we use the PQFP version

since commit 3e90772f76010c315474bde59eaca7cc4c94d645
ARM: at91: fix at91rm9200 soc subtype handling

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: stable at kernel.org
---

 arch/arm/mach-at91/setup.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 19cdd0b..28750c5 100644
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
1.7.10.4
