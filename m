From: viniciusfre@gmail.com (Vinicius Maciel)
Date: Mon, 13 Feb 2017 09:05:53 -0300
Subject: [PATCH] spi/sun6i: Add Master Sample Data Mode for SPI
Message-ID: <20170213120553.6479-1-viniciusfre@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to work appropriately, some SPI chips, such as
max11043, require SPI master samples the data at the
correct edge.

This patch add Master Sample Data Mode bit in normal sample mode.

Signed-off-by: Vinicius Maciel <viniciusfre@gmail.com>
---
 drivers/spi/spi-sun6i.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index e3114832c485..170f4ad407dd 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -43,6 +43,7 @@
 #define SUN6I_TFR_CTL_CS_LEVEL			BIT(7)
 #define SUN6I_TFR_CTL_DHB			BIT(8)
 #define SUN6I_TFR_CTL_FBS			BIT(12)
+#define SUN6I_TFR_CTL_SDM			BIT(13)
 #define SUN6I_TFR_CTL_XCH			BIT(31)
 
 #define SUN6I_INT_CTL_REG		0x10
@@ -342,6 +343,8 @@ static int sun6i_spi_runtime_resume(struct device *dev)
 
 	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
 			SUN6I_GBL_CTL_BUS_ENABLE | SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
+        sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG,
+			SUN6I_TFR_CTL_SDM);
 
 	return 0;
 
-- 
2.11.0
