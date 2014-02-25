From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 25 Feb 2014 11:03:46 +0100
Subject: [PATCH 1/2] regulator: dummy: Should be always-on
In-Reply-To: <1393322627-26543-1-git-send-email-mpa@pengutronix.de>
References: <1393322627-26543-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1393322627-26543-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator dummy does not have any enable operations. So it is always_on.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/dummy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index df9f425..2436db9 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -25,7 +25,11 @@
 
 struct regulator_dev *dummy_regulator_rdev;
 
-static struct regulator_init_data dummy_initdata;
+static struct regulator_init_data dummy_initdata = {
+	.constraints = {
+		.always_on = 1,
+	},
+};
 
 static struct regulator_ops dummy_ops;
 
-- 
1.8.5.3
