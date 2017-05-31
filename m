From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 03:06:23 +0200
Subject: [PATCH v3 5/6] ARM: at91: add SAMx7 SoC detection
In-Reply-To: <20170531010624.32552-1-alexandre.belloni@free-electrons.com>
References: <20170531010624.32552-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170531010624.32552-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Szemz? Andr?s <sza@esh.hu>

Add SAME70/V71/S70/V70 chip-ids to SoC detection.

Signed-off-by: Szemz? Andr?s <sza@esh.hu>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/soc/atmel/soc.c | 24 ++++++++++++++++++++++++
 drivers/soc/atmel/soc.h | 26 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 4790094b498e..7c588f99dcd1 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -107,6 +107,30 @@ static const struct at91_soc __initconst socs[] = {
 	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D44_EXID_MATCH,
 		 "sama5d44", "sama5d4"),
 #endif
+#ifdef CONFIG_SOC_SAMX7
+	AT91_SOC(SAME70Q21_CIDR_MATCH, SAME70Q21_EXID_MATCH,
+		 "same70q21", "samx7"),
+	AT91_SOC(SAME70Q20_CIDR_MATCH, SAME70Q20_EXID_MATCH,
+		 "same70q20", "samx7"),
+	AT91_SOC(SAME70Q19_CIDR_MATCH, SAME70Q19_EXID_MATCH,
+		 "same70q19", "samx7"),
+	AT91_SOC(SAMS70Q21_CIDR_MATCH, SAMS70Q21_EXID_MATCH,
+		 "sams70q21", "samx7"),
+	AT91_SOC(SAMS70Q20_CIDR_MATCH, SAMS70Q20_EXID_MATCH,
+		 "sams70q20", "samx7"),
+	AT91_SOC(SAMS70Q19_CIDR_MATCH, SAMS70Q19_EXID_MATCH,
+		 "sams70q19", "samx7"),
+	AT91_SOC(SAMV71Q21_CIDR_MATCH, SAMV71Q21_EXID_MATCH,
+		 "samv71q21", "samx7"),
+	AT91_SOC(SAMV71Q20_CIDR_MATCH, SAMV71Q20_EXID_MATCH,
+		 "samv71q20", "samx7"),
+	AT91_SOC(SAMV71Q19_CIDR_MATCH, SAMV71Q19_EXID_MATCH,
+		 "samv71q19", "samx7"),
+	AT91_SOC(SAMV70Q20_CIDR_MATCH, SAMV70Q20_EXID_MATCH,
+		 "samv70q20", "samx7"),
+	AT91_SOC(SAMV70Q19_CIDR_MATCH, SAMV70Q19_EXID_MATCH,
+		 "samv70q19", "samx7"),
+#endif
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 228efded5085..a90bd5b0ef8f 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -88,4 +88,30 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA5D43_EXID_MATCH		0x00000003
 #define SAMA5D44_EXID_MATCH		0x00000004
 
+#define SAME70Q21_CIDR_MATCH		0x21020e00
+#define SAME70Q21_EXID_MATCH		0x00000002
+#define SAME70Q20_CIDR_MATCH		0x21020c00
+#define SAME70Q20_EXID_MATCH		0x00000002
+#define SAME70Q19_CIDR_MATCH		0x210d0a00
+#define SAME70Q19_EXID_MATCH		0x00000002
+
+#define SAMS70Q21_CIDR_MATCH		0x21120e00
+#define SAMS70Q21_EXID_MATCH		0x00000002
+#define SAMS70Q20_CIDR_MATCH		0x21120c00
+#define SAMS70Q20_EXID_MATCH		0x00000002
+#define SAMS70Q19_CIDR_MATCH		0x211d0a00
+#define SAMS70Q19_EXID_MATCH		0x00000002
+
+#define SAMV71Q21_CIDR_MATCH		0x21220e00
+#define SAMV71Q21_EXID_MATCH		0x00000002
+#define SAMV71Q20_CIDR_MATCH		0x21220c00
+#define SAMV71Q20_EXID_MATCH		0x00000002
+#define SAMV71Q19_CIDR_MATCH		0x212d0a00
+#define SAMV71Q19_EXID_MATCH		0x00000002
+
+#define SAMV70Q20_CIDR_MATCH		0x21320c00
+#define SAMV70Q20_EXID_MATCH		0x00000002
+#define SAMV70Q19_CIDR_MATCH		0x213d0a00
+#define SAMV70Q19_EXID_MATCH		0x00000002
+
 #endif /* __AT91_SOC_H */
-- 
2.11.0
