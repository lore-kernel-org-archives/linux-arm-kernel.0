From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  4 Mar 2017 11:20:11 +0100
Subject: [PATCH v2] phy: meson8b-usb2: fix offsets for some of the registers
In-Reply-To: <20170113185358.8362-1-martin.blumenstingl@googlemail.com>
References: <20170113185358.8362-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170304102011.14944-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register offsets for REG_DBG_UART (and all following) were off by
0x4. This was not a problem yet because these registers are currently
not used by the driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
changes since v1:
- added Jerome's Reviewed-By

 drivers/phy/phy-meson8b-usb2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-meson8b-usb2.c b/drivers/phy/phy-meson8b-usb2.c
index 33c9f4ba157d..30f56a6a411f 100644
--- a/drivers/phy/phy-meson8b-usb2.c
+++ b/drivers/phy/phy-meson8b-usb2.c
@@ -81,9 +81,9 @@
 	#define REG_ADP_BC_ACA_PIN_GND			BIT(25)
 	#define REG_ADP_BC_ACA_PIN_FLOAT		BIT(26)
 
-#define REG_DBG_UART					0x14
+#define REG_DBG_UART					0x10
 
-#define REG_TEST					0x18
+#define REG_TEST					0x14
 	#define REG_TEST_DATA_IN_MASK			GENMASK(3, 0)
 	#define REG_TEST_EN_MASK			GENMASK(7, 4)
 	#define REG_TEST_ADDR_MASK			GENMASK(11, 8)
@@ -93,7 +93,7 @@
 	#define REG_TEST_DATA_OUT_MASK			GENMASK(19, 16)
 	#define REG_TEST_DISABLE_ID_PULLUP		BIT(20)
 
-#define REG_TUNE					0x1c
+#define REG_TUNE					0x18
 	#define REG_TUNE_TX_RES_TUNE_MASK		GENMASK(1, 0)
 	#define REG_TUNE_TX_HSXV_TUNE_MASK		GENMASK(3, 2)
 	#define REG_TUNE_TX_VREF_TUNE_MASK		GENMASK(7, 4)
-- 
2.12.0
