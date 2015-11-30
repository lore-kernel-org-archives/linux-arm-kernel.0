From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 30 Nov 2015 10:28:04 +0800
Subject: [PATCH v2 1/5] thermal: rockchip: fix a trivial typo
In-Reply-To: <1448850488-16325-1-git-send-email-wxt@rock-chips.com>
References: <1448850488-16325-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1448850488-16325-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset trys to dictate unified format for driver.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- As Heiko comments, move to documenting the fields in the header
  instead of inside the table.

Changes in v1:
- Search more trivial typo for me.

 drivers/thermal/rockchip_thermal.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e845841..ae796ec 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -38,7 +38,7 @@ enum tshut_mode {
 };
 
 /**
- * the system Temperature Sensors tshut(tshut) polarity
+ * The system Temperature Sensors tshut(tshut) polarity
  * the bit 8 is tshut polarity.
  * 0: low active, 1: high active
  */
@@ -57,10 +57,10 @@ enum sensor_id {
 };
 
 /**
-* The conversion table has the adc value and temperature.
-* ADC_DECREMENT is the adc value decremnet.(e.g. v2_code_table)
-* ADC_INCREMNET is the adc value incremnet.(e.g. v3_code_table)
-*/
+ * The conversion table has the adc value and temperature.
+ * ADC_DECREMENT: the adc value is of diminishing.(e.g. v2_code_table)
+ * ADC_INCREMENT: the adc value is incremental.(e.g. v3_code_table)
+ */
 enum adc_sort_mode {
 	ADC_DECREMENT = 0,
 	ADC_INCREMENT,
@@ -72,16 +72,17 @@ enum adc_sort_mode {
  */
 #define SOC_MAX_SENSORS	2
 
+/**
+ * struct chip_tsadc_table: hold information about chip-specific differences
+ * @id: conversion table
+ * @length: size of conversion table
+ * @data_mask: mask to apply on data inputs
+ * @mode: sort mode of this adc variant (incrementing or decrementing)
+ */
 struct chip_tsadc_table {
 	const struct tsadc_table *id;
-
-	/* the array table size*/
 	unsigned int length;
-
-	/* that analogic mask data */
 	u32 data_mask;
-
-	/* the sort mode is adc value that increment or decrement in table */
 	enum adc_sort_mode mode;
 };
 
@@ -617,7 +618,7 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 	return 0;
 }
 
-/*
+/**
  * Reset TSADC Controller, reset all tsadc registers.
  */
 static void rockchip_thermal_reset_controller(struct reset_control *reset)
-- 
1.9.1
