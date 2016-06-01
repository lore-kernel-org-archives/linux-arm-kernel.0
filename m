From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 11:53:58 +0200
Subject: [PATCH v7 3/6] mfd: max8997: Change irq names to upper case
In-Reply-To: <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
References: <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464774841-1439-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Baldyga <r.baldyga@samsung.com>

This patch changes naming convention of MUIC interrupts form CamelCase
to upper case. It makes names more readable and consistent with another
interrupt names in max8997 driver.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

[For the mfd part]
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
[k.kozlowski: Collect acks, rebase on v4.6-rc6]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/extcon/extcon-max8997.c     | 32 ++++++++++++++++----------------
 include/linux/mfd/max8997-private.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9d27cc23038f..68754ac2c8ea 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -46,15 +46,15 @@ struct max8997_muic_irq {
 };
 
 static struct max8997_muic_irq muic_irqs[] = {
-	{ MAX8997_MUICIRQ_ADCError,	"muic-ADCERROR" },
-	{ MAX8997_MUICIRQ_ADCLow,	"muic-ADCLOW" },
-	{ MAX8997_MUICIRQ_ADC,		"muic-ADC" },
-	{ MAX8997_MUICIRQ_VBVolt,	"muic-VBVOLT" },
-	{ MAX8997_MUICIRQ_DBChg,	"muic-DBCHG" },
-	{ MAX8997_MUICIRQ_DCDTmr,	"muic-DCDTMR" },
-	{ MAX8997_MUICIRQ_ChgDetRun,	"muic-CHGDETRUN" },
-	{ MAX8997_MUICIRQ_ChgTyp,	"muic-CHGTYP" },
-	{ MAX8997_MUICIRQ_OVP,		"muic-OVP" },
+	{ MAX8997_MUICIRQ_ADCERROR,	"MUIC-ADCERROR" },
+	{ MAX8997_MUICIRQ_ADCLOW,	"MUIC-ADCLOW" },
+	{ MAX8997_MUICIRQ_ADC,		"MUIC-ADC" },
+	{ MAX8997_MUICIRQ_VBVOLT,	"MUIC-VBVOLT" },
+	{ MAX8997_MUICIRQ_DBCHG,	"MUIC-DBCHG" },
+	{ MAX8997_MUICIRQ_DCDTMR,	"MUIC-DCDTMR" },
+	{ MAX8997_MUICIRQ_CHGDETRUN,	"MUIC-CHGDETRUN" },
+	{ MAX8997_MUICIRQ_CHGTYP,	"MUIC-CHGTYP" },
+	{ MAX8997_MUICIRQ_OVP,		"MUIC-OVP" },
 };
 
 /* Define supported cable type */
@@ -540,17 +540,17 @@ static void max8997_muic_irq_work(struct work_struct *work)
 	}
 
 	switch (irq_type) {
-	case MAX8997_MUICIRQ_ADCError:
-	case MAX8997_MUICIRQ_ADCLow:
+	case MAX8997_MUICIRQ_ADCERROR:
+	case MAX8997_MUICIRQ_ADCLOW:
 	case MAX8997_MUICIRQ_ADC:
 		/* Handle all of cable except for charger cable */
 		ret = max8997_muic_adc_handler(info);
 		break;
-	case MAX8997_MUICIRQ_VBVolt:
-	case MAX8997_MUICIRQ_DBChg:
-	case MAX8997_MUICIRQ_DCDTmr:
-	case MAX8997_MUICIRQ_ChgDetRun:
-	case MAX8997_MUICIRQ_ChgTyp:
+	case MAX8997_MUICIRQ_VBVOLT:
+	case MAX8997_MUICIRQ_DBCHG:
+	case MAX8997_MUICIRQ_DCDTMR:
+	case MAX8997_MUICIRQ_CHGDETRUN:
+	case MAX8997_MUICIRQ_CHGTYP:
 		/* Handle charger cable */
 		ret = max8997_muic_chg_handler(info);
 		break;
diff --git a/include/linux/mfd/max8997-private.h b/include/linux/mfd/max8997-private.h
index f42ea222988f..2817fa69383e 100644
--- a/include/linux/mfd/max8997-private.h
+++ b/include/linux/mfd/max8997-private.h
@@ -411,14 +411,14 @@ enum max8997_irq {
 
 enum max8997_irq_muic {
 	MAX8997_MUICIRQ_ADC,
-	MAX8997_MUICIRQ_ADCLow,
-	MAX8997_MUICIRQ_ADCError,
-
-	MAX8997_MUICIRQ_ChgTyp,
-	MAX8997_MUICIRQ_ChgDetRun,
-	MAX8997_MUICIRQ_DCDTmr,
-	MAX8997_MUICIRQ_DBChg,
-	MAX8997_MUICIRQ_VBVolt,
+	MAX8997_MUICIRQ_ADCLOW,
+	MAX8997_MUICIRQ_ADCERROR,
+
+	MAX8997_MUICIRQ_CHGTYP,
+	MAX8997_MUICIRQ_CHGDETRUN,
+	MAX8997_MUICIRQ_DCDTMR,
+	MAX8997_MUICIRQ_DBCHG,
+	MAX8997_MUICIRQ_VBVOLT,
 
 	MAX8997_MUICIRQ_OVP,
 
-- 
1.9.1
