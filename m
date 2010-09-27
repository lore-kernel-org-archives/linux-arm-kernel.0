From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 27 Sep 2010 14:32:26 +0200
Subject: [PATCH v3 4/5] mfd: regulator: max8998: voltages and GPIOs defined at
	platform data structure
In-Reply-To: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285590747-32404-5-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/mfd/max8998.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/max8998.h b/include/linux/mfd/max8998.h
index d47ed4c..f8c9f88 100644
--- a/include/linux/mfd/max8998.h
+++ b/include/linux/mfd/max8998.h
@@ -70,12 +70,24 @@ struct max8998_regulator_data {
  * @num_regulators: number of regultors used
  * @irq_base: base IRQ number for max8998, required for IRQs
  * @ono: power onoff IRQ number for max8998
+ * @buck1_max_voltage1: BUCK1 maximum alowed voltage register 1
+ * @buck1_max_voltage2: BUCK1 maximum alowed voltage register 2
+ * @buck2_max_voltage: BUCK2 maximum alowed voltage
+ * @buck1_set1: BUCK1 gpio pin 1 to set output voltage
+ * @buck1_set2: BUCK1 gpio pin 2 to set output voltage
+ * @buck2_set3: BUCK2 gpio pin to set output voltage
  */
 struct max8998_platform_data {
 	struct max8998_regulator_data	*regulators;
 	int				num_regulators;
 	int				irq_base;
 	int				ono;
+	int                             buck1_max_voltage1;
+	int                             buck1_max_voltage2;
+	int                             buck2_max_voltage;
+	int				buck1_set1;
+	int				buck1_set2;
+	int				buck2_set3;
 };
 
 #endif /*  __LINUX_MFD_MAX8998_H */
-- 
1.7.1
