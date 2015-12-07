From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:27 +0000
Subject: [PATCH 14/19] mfd: cros_ec_spi: Repair comparison ordering issue
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Comparisons should place the constant on the right side of the test
+       BUG_ON(EC_MSG_PREAMBLE_COUNT > ec_dev->din_size);

WARNING: Comparisons should place the constant on the right side of the test
+       BUG_ON(EC_MSG_PREAMBLE_COUNT > ec_dev->din_size);

total: 0 errors, 2 warnings, 731 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cros_ec_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 30a296b..e1b121c 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -175,7 +175,7 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
 	unsigned long deadline;
 	int todo;
 
-	BUG_ON(EC_MSG_PREAMBLE_COUNT > ec_dev->din_size);
+	BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
 
 	/* Receive data until we see the header byte */
 	deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
@@ -283,7 +283,7 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 	unsigned long deadline;
 	int todo;
 
-	BUG_ON(EC_MSG_PREAMBLE_COUNT > ec_dev->din_size);
+	BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
 
 	/* Receive data until we see the header byte */
 	deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
-- 
1.9.1
