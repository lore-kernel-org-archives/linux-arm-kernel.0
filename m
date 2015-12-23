From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 23 Dec 2015 11:58:35 +0100
Subject: [PATCH 2/6] regulator: lp872x: Get rid of duplicate reference to DVS
 GPIO
In-Reply-To: <1450868319-20513-1-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
Message-ID: <1450868319-20513-3-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lp872x structure holds a reference to the DVS GPIO, but it is never actually
used anywhere, since a first reference exists from the lp872x_dvs structure.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/regulator/lp872x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 9412353..19d7584 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -108,7 +108,6 @@ struct lp872x {
 	struct lp872x_platform_data *pdata;
 	int num_regulators;
 	enum lp872x_dvs_state dvs_pin;
-	int dvs_gpio;
 };
 
 /* LP8720/LP8725 shared voltage table for LDOs */
@@ -752,7 +751,6 @@ static int lp872x_init_dvs(struct lp872x *lp)
 	}
 
 	lp->dvs_pin = pinstate;
-	lp->dvs_gpio = gpio;
 
 	return 0;
 
-- 
1.9.1
