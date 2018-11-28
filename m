From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 28 Nov 2018 12:00:35 +0100
Subject: [PATCH] ARM: at91: add support in soc driver for LPDDR2 SiP
Message-ID: <20181128110035.10407-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some more SiP components to be detected by this soc.c driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/soc/atmel/soc.c | 8 ++++++++
 drivers/soc/atmel/soc.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 4dd03b099c89..2cc272ddf906 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -90,12 +90,20 @@ static const struct at91_soc __initconst socs[] = {
 		 "sama5d27c 128MiB SiP", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_D5M_EXID_MATCH,
 		 "sama5d27c 64MiB SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_LD1G_EXID_MATCH,
+		 "sama5d27c 128MiB LPDDR2 SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_LD2G_EXID_MATCH,
+		 "sama5d27c 256MiB LPDDR2 SiP", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CU_EXID_MATCH,
 		 "sama5d28", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CN_EXID_MATCH,
 		 "sama5d28", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28C_D1G_EXID_MATCH,
 		 "sama5d28c 128MiB SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28C_LD1G_EXID_MATCH,
+		 "sama5d28c 128MiB LPDDR2 SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28C_LD2G_EXID_MATCH,
+		 "sama5d28c 256MiB LPDDR2 SiP", "sama5d2"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
 		 "sama5d31", "sama5d3"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 94cd5d1ab502..ed89b24ecee1 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -73,9 +73,13 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA5D26CU_EXID_MATCH		0x00000012
 #define SAMA5D27C_D1G_EXID_MATCH	0x00000033
 #define SAMA5D27C_D5M_EXID_MATCH	0x00000032
+#define SAMA5D27C_LD1G_EXID_MATCH	0x00000061
+#define SAMA5D27C_LD2G_EXID_MATCH	0x00000062
 #define SAMA5D27CU_EXID_MATCH		0x00000011
 #define SAMA5D27CN_EXID_MATCH		0x00000021
 #define SAMA5D28C_D1G_EXID_MATCH	0x00000013
+#define SAMA5D28C_LD1G_EXID_MATCH	0x00000071
+#define SAMA5D28C_LD2G_EXID_MATCH	0x00000072
 #define SAMA5D28CU_EXID_MATCH		0x00000010
 #define SAMA5D28CN_EXID_MATCH		0x00000020
 
-- 
2.15.1
