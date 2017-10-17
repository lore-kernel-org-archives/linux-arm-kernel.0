From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Oct 2017 14:47:07 +0200
Subject: [PATCH v3 5/5] irqchip: rtd119x: Add RTD1195 definitions
In-Reply-To: <20171017124708.6242-1-afaerber@suse.de>
References: <20171017124708.6242-1-afaerber@suse.de>
Message-ID: <20171017124708.6242-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible strings and bit definitions for Realtek RTD1195 SoC.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: New
 
 drivers/irqchip/irq-rtd119x-mux.c | 99 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-rtd119x-mux.c b/drivers/irqchip/irq-rtd119x-mux.c
index ad6e2093fcd3..84c592ad7421 100644
--- a/drivers/irqchip/irq-rtd119x-mux.c
+++ b/drivers/irqchip/irq-rtd119x-mux.c
@@ -1,5 +1,5 @@
 /*
- * Realtek RTD129x IRQ mux
+ * Realtek RTD119x/RTD129x IRQ mux
  *
  * Copyright (c) 2017 Andreas F?rber
  *
@@ -144,6 +144,81 @@ static struct irq_domain_ops rtd119x_mux_irq_domain_ops = {
 	.map	= rtd119x_mux_irq_domain_map,
 };
 
+enum rtd119x_iso_isr_bits {
+	RTD119X_ISO_ISR_TC3_SHIFT = 1,
+	RTD119X_ISO_ISR_UR0_SHIFT = 2,
+	RTD119X_ISO_ISR_IRDA_SHIFT = 5,
+	RTD119X_ISO_ISR_WDOG_NMI_SHIFT = 7,
+	RTD119X_ISO_ISR_I2C0_SHIFT = 8,
+	RTD119X_ISO_ISR_TC4_SHIFT = 9,
+	RTD119X_ISO_ISR_I2C6_SHIFT = 10,
+	RTD119X_ISO_ISR_RTC_HSEC_SHIFT = 12,
+	RTD119X_ISO_ISR_RTC_ALARM_SHIFT = 13,
+	RTD119X_ISO_ISR_VFD_WDONE_SHIFT = 14,
+	RTD119X_ISO_ISR_VFD_ARDKPADA_SHIFT = 15,
+	RTD119X_ISO_ISR_VFD_ARDKPADDA_SHIFT = 16,
+	RTD119X_ISO_ISR_VFD_ARDSWA_SHIFT = 17,
+	RTD119X_ISO_ISR_VFD_ARDSWDA_SHIFT = 18,
+	RTD119X_ISO_ISR_GPIOA_SHIFT = 19,
+	RTD119X_ISO_ISR_GPIODA_SHIFT = 20,
+	RTD119X_ISO_ISR_CEC_SHIFT = 22,
+};
+
+static const u32 rtd119x_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD119X_ISO_ISR_UR0_SHIFT]		= BIT(2),
+	[RTD119X_ISO_ISR_IRDA_SHIFT]		= BIT(5),
+	[RTD119X_ISO_ISR_I2C0_SHIFT]		= BIT(8),
+	[RTD119X_ISO_ISR_I2C6_SHIFT]		= BIT(10),
+	[RTD119X_ISO_ISR_RTC_HSEC_SHIFT]	= BIT(12),
+	[RTD119X_ISO_ISR_RTC_ALARM_SHIFT]	= BIT(13),
+	[RTD119X_ISO_ISR_VFD_WDONE_SHIFT]	= BIT(14),
+	[RTD119X_ISO_ISR_VFD_ARDKPADA_SHIFT]	= BIT(15),
+	[RTD119X_ISO_ISR_VFD_ARDKPADDA_SHIFT]	= BIT(16),
+	[RTD119X_ISO_ISR_VFD_ARDSWA_SHIFT]	= BIT(17),
+	[RTD119X_ISO_ISR_VFD_ARDSWDA_SHIFT]	= BIT(18),
+	[RTD119X_ISO_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD119X_ISO_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD119X_ISO_ISR_CEC_SHIFT]		= BIT(22),
+};
+
+enum rtd119x_misc_isr_bits {
+	RTD119X_MIS_ISR_WDOG_NMI_SHIFT = 2,
+	RTD119X_MIS_ISR_UR1_SHIFT,
+	RTD119X_MIS_ISR_I2C1_SHIFT,
+	RTD119X_MIS_ISR_UR1_TO_SHIFT,
+	RTD119X_MIS_ISR_TC0_SHIFT,
+	RTD119X_MIS_ISR_TC1_SHIFT,
+	RTD119X_MIS_ISR_RTC_HSEC_SHIFT = 9,
+	RTD119X_MIS_ISR_RTC_MIN_SHIFT,
+	RTD119X_MIS_ISR_RTC_HOUR_SHIFT,
+	RTD119X_MIS_ISR_RTC_DATE_SHIFT,
+	RTD119X_MIS_ISR_I2C5_SHIFT = 14,
+	RTD119X_MIS_ISR_I2C4_SHIFT,
+	RTD119X_MIS_ISR_GPIOA_SHIFT = 19,
+	RTD119X_MIS_ISR_GPIODA_SHIFT,
+	RTD119X_MIS_ISR_LSADC_SHIFT,
+	RTD119X_MIS_ISR_I2C3_SHIFT = 23,
+	RTD119X_MIS_ISR_I2C2_SHIFT = 26,
+	RTD119X_MIS_ISR_GSPI_SHIFT,
+};
+
+static const u32 rtd119x_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD119X_MIS_ISR_UR1_SHIFT]		= BIT(3),
+	[RTD119X_MIS_ISR_I2C1_SHIFT]		= BIT(4),
+	[RTD119X_MIS_ISR_UR1_TO_SHIFT]		= BIT(5),
+	[RTD119X_MIS_ISR_RTC_MIN_SHIFT]		= BIT(10),
+	[RTD119X_MIS_ISR_RTC_HOUR_SHIFT]	= BIT(11),
+	[RTD119X_MIS_ISR_RTC_DATE_SHIFT]	= BIT(12),
+	[RTD119X_MIS_ISR_I2C5_SHIFT]		= BIT(14),
+	[RTD119X_MIS_ISR_I2C4_SHIFT]		= BIT(15),
+	[RTD119X_MIS_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD119X_MIS_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD119X_MIS_ISR_LSADC_SHIFT]		= BIT(21),
+	[RTD119X_MIS_ISR_I2C2_SHIFT]		= BIT(26),
+	[RTD119X_MIS_ISR_GSPI_SHIFT]		= BIT(27),
+	[RTD119X_MIS_ISR_I2C3_SHIFT]		= BIT(28),
+};
+
 enum rtd129x_iso_isr_bits {
 	RTD1295_ISO_ISR_UR0_SHIFT = 2,
 	RTD1295_ISO_ISR_IRDA_SHIFT = 5,
@@ -214,6 +289,13 @@ static const u32 rtd129x_misc_isr_to_scpu_int_en_mask[32] = {
 	[RTD1295_ISR_FAN_SHIFT]			= BIT(29),
 };
 
+static const struct rtd119x_irq_mux_info rtd119x_iso_irq_mux_info = {
+	.isr_offset		= 0x0,
+	.umsk_isr_offset	= 0x4,
+	.scpu_int_en_offset	= 0x40,
+	.isr_to_scpu_int_en_mask = rtd119x_iso_isr_to_scpu_int_en_mask,
+};
+
 static const struct rtd119x_irq_mux_info rtd129x_iso_irq_mux_info = {
 	.isr_offset		= 0x0,
 	.umsk_isr_offset	= 0x4,
@@ -221,6 +303,13 @@ static const struct rtd119x_irq_mux_info rtd129x_iso_irq_mux_info = {
 	.isr_to_scpu_int_en_mask = rtd129x_iso_isr_to_scpu_int_en_mask,
 };
 
+static const struct rtd119x_irq_mux_info rtd119x_misc_irq_mux_info = {
+	.umsk_isr_offset	= 0x8,
+	.isr_offset		= 0xc,
+	.scpu_int_en_offset	= 0x80,
+	.isr_to_scpu_int_en_mask = rtd119x_misc_isr_to_scpu_int_en_mask,
+};
+
 static const struct rtd119x_irq_mux_info rtd129x_misc_irq_mux_info = {
 	.umsk_isr_offset	= 0x8,
 	.isr_offset		= 0xc,
@@ -230,9 +319,15 @@ static const struct rtd119x_irq_mux_info rtd129x_misc_irq_mux_info = {
 
 static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
 	{
+		.compatible = "realtek,rtd1195-iso-irq-mux",
+		.data = &rtd119x_iso_irq_mux_info,
+	}, {
 		.compatible = "realtek,rtd1295-iso-irq-mux",
 		.data = &rtd129x_iso_irq_mux_info,
 	}, {
+		.compatible = "realtek,rtd1195-misc-irq-mux",
+		.data = &rtd119x_misc_irq_mux_info,
+	}, {
 		.compatible = "realtek,rtd1295-misc-irq-mux",
 		.data = &rtd129x_misc_irq_mux_info,
 	}, {
@@ -287,5 +382,7 @@ static int __init rtd119x_irq_mux_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(rtd1195_iso_mux, "realtek,rtd1195-iso-irq-mux", rtd119x_irq_mux_init);
 IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd119x_irq_mux_init);
+IRQCHIP_DECLARE(rtd1195_misc_mux, "realtek,rtd1195-misc-irq-mux", rtd119x_irq_mux_init);
 IRQCHIP_DECLARE(rtd1295_misc_mux, "realtek,rtd1295-misc-irq-mux", rtd119x_irq_mux_init);
-- 
2.13.6
