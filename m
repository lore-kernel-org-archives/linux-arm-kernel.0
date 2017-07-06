From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 6 Jul 2017 11:35:27 +0300
Subject: [PATCH v3 3/5] drivers: soc: atmel: Add basic support for new sama5d2
 SiPs
In-Reply-To: <1499330129-29319-1-git-send-email-claudiu.beznea@microchip.com>
References: <1499330129-29319-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1499330129-29319-4-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Add basic support for new sama5d2 System in a Package chips.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
[claudiu.beznea at microchip.com: use MiB instead of MB]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 8 ++++++++
 drivers/soc/atmel/soc.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index c1363c8..4dd03b0 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -72,6 +72,8 @@ static const struct at91_soc __initconst socs[] = {
 		 "sama5d21", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D22CU_EXID_MATCH,
 		 "sama5d22", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D225C_D1M_EXID_MATCH,
+		 "sama5d225c 16MiB SiP", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D23CU_EXID_MATCH,
 		 "sama5d23", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D24CX_EXID_MATCH,
@@ -84,10 +86,16 @@ static const struct at91_soc __initconst socs[] = {
 		 "sama5d27", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27CN_EXID_MATCH,
 		 "sama5d27", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_D1G_EXID_MATCH,
+		 "sama5d27c 128MiB SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_D5M_EXID_MATCH,
+		 "sama5d27c 64MiB SiP", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CU_EXID_MATCH,
 		 "sama5d28", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CN_EXID_MATCH,
 		 "sama5d28", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28C_D1G_EXID_MATCH,
+		 "sama5d28c 128MiB SiP", "sama5d2"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
 		 "sama5d31", "sama5d3"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index a90bd5b..94cd5d1 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -64,14 +64,18 @@ at91_soc_init(const struct at91_soc *socs);
 
 #define SAMA5D2_CIDR_MATCH		0x0a5c08c0
 #define SAMA5D21CU_EXID_MATCH		0x0000005a
+#define SAMA5D225C_D1M_EXID_MATCH	0x00000053
 #define SAMA5D22CU_EXID_MATCH		0x00000059
 #define SAMA5D22CN_EXID_MATCH		0x00000069
 #define SAMA5D23CU_EXID_MATCH		0x00000058
 #define SAMA5D24CX_EXID_MATCH		0x00000004
 #define SAMA5D24CU_EXID_MATCH		0x00000014
 #define SAMA5D26CU_EXID_MATCH		0x00000012
+#define SAMA5D27C_D1G_EXID_MATCH	0x00000033
+#define SAMA5D27C_D5M_EXID_MATCH	0x00000032
 #define SAMA5D27CU_EXID_MATCH		0x00000011
 #define SAMA5D27CN_EXID_MATCH		0x00000021
+#define SAMA5D28C_D1G_EXID_MATCH	0x00000013
 #define SAMA5D28CU_EXID_MATCH		0x00000010
 #define SAMA5D28CN_EXID_MATCH		0x00000020
 
-- 
2.7.4
