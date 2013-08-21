From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 21 Aug 2013 15:53:46 -0500
Subject: [PATCHv3 3/4] clocksource: dw_apb_timer: Move timer defines to header
 file.
In-Reply-To: <1377118427-20644-1-git-send-email-dinguyen@altera.com>
References: <1377118427-20644-1-git-send-email-dinguyen@altera.com>
Message-ID: <1377118427-20644-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Move all dw_apb_timer defines to include/linux/dw_apb_timer.h.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Rob Herring <rob.herring@calxeda.com>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Jamie Iles <jamie@jamieiles.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Pavel Machek <pavel@denx.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 include/linux/dw_apb_timer.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
index 1f79b20..1d2b949 100644
--- a/include/linux/dw_apb_timer.h
+++ b/include/linux/dw_apb_timer.h
@@ -19,6 +19,25 @@
 
 #define APBTMRS_REG_SIZE       0x14
 
+#define APBT_MIN_PERIOD                 4
+#define APBT_MIN_DELTA_USEC             200
+
+#define APBTMR_N_LOAD_COUNT             0x00
+#define APBTMR_N_CURRENT_VALUE          0x04
+#define APBTMR_N_CONTROL                0x08
+#define APBTMR_N_EOI                    0x0c
+#define APBTMR_N_INT_STATUS             0x10
+
+#define APBTMRS_INT_STATUS              0xa0
+#define APBTMRS_EOI                     0xa4
+#define APBTMRS_RAW_INT_STATUS          0xa8
+#define APBTMRS_COMP_VERSION            0xac
+
+#define APBTMR_CONTROL_ENABLE           (1 << 0)
+/* 1: periodic, 0:free running. */
+#define APBTMR_CONTROL_MODE_PERIODIC    (1 << 1)
+#define APBTMR_CONTROL_INT              (1 << 2)
+
 struct dw_apb_timer {
 	void __iomem				*base;
 	unsigned long				freq;
-- 
1.7.9.5
