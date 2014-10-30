From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 12:20:40 +0100
Subject: [PATCH v3 01/14] mfd: max77686/802: Map regulator driver to its own
 of_node
In-Reply-To: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414668053-31370-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_compatible fields for max77686 and max77802 regulator drivers.
The driver's node should be the same as voltage-regulators node. This
simplifies parsing of regulators init data from DTS.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/max77686.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 929795eae9fc..9e1046bdef90 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -38,13 +38,19 @@
 #define I2C_ADDR_RTC	(0x0C >> 1)
 
 static const struct mfd_cell max77686_devs[] = {
-	{ .name = "max77686-pmic", },
+	{
+		.name = "max77686-pmic",
+		.of_compatible = "maxim,max77686-pmic",
+	},
 	{ .name = "max77686-rtc", },
 	{ .name = "max77686-clk", },
 };
 
 static const struct mfd_cell max77802_devs[] = {
-	{ .name = "max77802-pmic", },
+	{
+		.name = "max77802-pmic",
+		.of_compatible = "maxim,max77802-pmic",
+	},
 	{ .name = "max77802-clk", },
 	{ .name = "max77802-rtc", },
 };
-- 
1.9.1
