From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Apr 2012 18:01:20 +0200
Subject: [PATCH 1/5] ARM: AT91: Add platform data for the AT91 ADCs
In-Reply-To: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1333641684-20325-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT91 SoCs often embeds an ADC. This patch adds the needed
platform data to specify the informations required by the driver
to work properly.

For now, we only need the reference voltage and which channels
are available on the board.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 include/linux/platform_data/at91_adc.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/at91_adc.h

diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
new file mode 100644
index 0000000..1f71510
--- /dev/null
+++ b/include/linux/platform_data/at91_adc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2011 Free Electrons
+ *
+ * Licensed under the GPLv2 or later.
+ *
+ */
+
+#ifndef _AT91_ADC_H_
+#define _AT91_ADC_H_
+
+/**
+ * struct at91_adc_data - platform data for ADC driver
+ * @channels_used:	channels in use on the board as a bitmask
+ * @vref:		Reference voltage for the ADC in millivolts
+ */
+struct at91_adc_data {
+	unsigned long	channels_used;
+	u16		vref;
+};
+
+extern void __init at91_add_device_adc(struct at91_adc_data *data);
+
+#endif
-- 
1.7.5.4
