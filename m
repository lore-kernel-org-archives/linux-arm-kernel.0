From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu, 22 Jan 2015 00:09:41 +0100
Subject: [PATCH 1/2] ARM: ux500: Move struct
Message-ID: <1421881782-23716-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move struct ab8500_ext_regulator_cfg to  the only file that is now used in.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/regulator/ab8500-ext.c   |    6 ++++++
 include/linux/regulator/ab8500.h |    5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 84c1ee3..a40c701 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -25,6 +25,12 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/regulator/ab8500.h>
 
+
+/* AB8500 external regulators */
+struct ab8500_ext_regulator_cfg {
+	bool hwreq; /* requires hw mode or high power mode */
+};
+
 /**
  * struct ab8500_ext_regulator_info - ab8500 regulator information
  * @dev: device pointer
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index d8ecefa..802529b 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -300,11 +300,6 @@ enum ab8540_regulator_reg {
 	AB8540_NUM_REGULATOR_REGISTERS,
 };
 
-/* AB8500 external regulators */
-struct ab8500_ext_regulator_cfg {
-	bool hwreq; /* requires hw mode or high power mode */
-};
-
 enum ab8500_ext_regulator_id {
 	AB8500_EXT_SUPPLY1,
 	AB8500_EXT_SUPPLY2,
-- 
1.7.10.4
