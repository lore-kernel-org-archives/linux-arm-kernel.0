From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 18:52:37 +0100
Subject: [PATCH 1/6] ARM: at91: fix cap9 ddrsdr register
In-Reply-To: <20111129173514.GW15008@game.jcrosoft.org>
References: <20111129173514.GW15008@game.jcrosoft.org>
Message-ID: <1322589162-5212-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix AT91_DDRSDRC_MODE it's 3bit

add missing AT91_DDRSDRC_NR_14, AT91_DDRSDRC_DBW (16 and 32 bits support)

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h b/arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
index 976f4a6..d21932d 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
@@ -16,7 +16,7 @@
 #define AT91CAP9_DDRSDR_H
 
 #define AT91_DDRSDRC_MR		0x00	/* Mode Register */
-#define		AT91_DDRSDRC_MODE	(0xf << 0)		/* Command Mode */
+#define		AT91_DDRSDRC_MODE	(0x7 << 0)		/* Command Mode */
 #define			AT91_DDRSDRC_MODE_NORMAL		0
 #define			AT91_DDRSDRC_MODE_NOP		1
 #define			AT91_DDRSDRC_MODE_PRECHARGE	2
@@ -42,6 +42,7 @@
 #define			AT91_DDRSDRC_NR_11	(0 << 2)
 #define			AT91_DDRSDRC_NR_12	(1 << 2)
 #define			AT91_DDRSDRC_NR_13	(2 << 2)
+#define			AT91_DDRSDRC_NR_14	(3 << 2)
 #define		AT91_DDRSDRC_CAS	(7 << 4)		/* CAS Latency */
 #define			AT91_DDRSDRC_CAS_2	(2 << 4)
 #define			AT91_DDRSDRC_CAS_3	(3 << 4)
@@ -86,6 +87,9 @@
 #define			AT91_DDRSDRC_MD_LOW_POWER_SDR	1
 #define			AT91_DDRSDRC_MD_DDR		2
 #define			AT91_DDRSDRC_MD_LOW_POWER_DDR	3
+#define		AT91_DDRSDRC_DBW	(1 << 4)		/* Data Bus Width */
+#define			AT91_DDRSDRC_DBW_32BITS		(0 <<  4)
+#define			AT91_DDRSDRC_DBW_16BITS		(1 <<  4)
 
 #define AT91_DDRSDRC_DLLR	0x20	/* DLL Information Register */
 #define		AT91_DDRSDRC_MDINC	(1 << 0)		/* Master Delay increment */
-- 
1.7.7
