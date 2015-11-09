From: wxt@rock-chips.com (Caesar Wang)
Date: Mon,  9 Nov 2015 12:48:55 +0800
Subject: [PATCH v4 03/10] thermal: rockchip: trivial: fix typo in commit
In-Reply-To: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1447044542-30859-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- As Eduardo comments on patch v1, split in smaller changes.

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e72a69d..907a317 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -237,15 +237,19 @@ static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
 }
 
 /**
- * rk_tsadcv2_initialize - initialize TASDC Controller
- * (1) Set TSADCV2_AUTO_PERIOD, configure the interleave between
- * every two accessing of TSADC in normal operation.
- * (2) Set TSADCV2_AUTO_PERIOD_HT, configure the interleave between
- * every two accessing of TSADC after the temperature is higher
- * than COM_SHUT or COM_INT.
- * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE,
- * if the temperature is higher than COMP_INT or COMP_SHUT for
- * "debounce" times, TSADC controller will generate interrupt or TSHUT.
+ * rk_tsadcv2_initialize - initialize TASDC Controller.
+ *
+ * (1) Set TSADC_V2_AUTO_PERIOD:
+ *     Configure the interleave between every two accessing of
+ *     TSADC in normal operation.
+ *
+ * (2) Set TSADCV2_AUTO_PERIOD_HT:
+ *     Configure the interleave between every two accessing of
+ *     TSADC after the temperature is higher than COM_SHUT or COM_INT.
+ *
+ * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE:
+ *     If the temperature is higher than COMP_INT or COMP_SHUT for
+ *     "debounce" times, TSADC controller will generate interrupt or TSHUT.
  */
 static void rk_tsadcv2_initialize(void __iomem *regs,
 				  enum tshut_polarity tshut_polarity)
-- 
1.9.1
