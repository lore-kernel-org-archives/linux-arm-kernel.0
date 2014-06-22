From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 22 Jun 2014 17:31:42 +0200
Subject: [PATCH 2/5] regulator: act8865: set correct number of regulators in
 pdata
In-Reply-To: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1403451105-31929-3-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When platform data is populated from DT all the regulators are
instantiated and the value of num_regulators should be the number of
all available regulators rather than the number of matched ones.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/regulator/act8865-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index fe2c038..b03a0e8 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -230,7 +230,7 @@ static int act8865_pdata_from_dt(struct device *dev,
 	if (!pdata->regulators)
 		return -ENOMEM;
 
-	pdata->num_regulators = matched;
+	pdata->num_regulators = ARRAY_SIZE(act8865_matches);
 	regulator = pdata->regulators;
 
 	for (i = 0; i < ARRAY_SIZE(act8865_matches); i++) {
-- 
1.7.10.4
