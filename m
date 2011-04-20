From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 20 Apr 2011 15:41:29 +0200
Subject: [PATCH] pxa/magician: bq24022 regulator needs to be enabled
References: <E1QAkBF-0003bF-A0@outmx04.plus.net>
	<20110419084032.GA30743@rainbow> <20110419113201.GA32248@rainbow>
	<BANLkTim_=pwuOvkRfMz_ZQe=NtJfGijajA@mail.gmail.com>
Message-ID: <1303306891.2703.3.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add REGULATOR_CHANGE_STATUS flag to magician bq24022 regulator to enable charging. 

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/magician.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index a72993d..9984ef7 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -599,7 +599,7 @@ static struct regulator_consumer_supply bq24022_consumers[] = {
 static struct regulator_init_data bq24022_init_data = {
 	.constraints = {
 		.max_uA         = 500000,
-		.valid_ops_mask = REGULATOR_CHANGE_CURRENT,
+		.valid_ops_mask = REGULATOR_CHANGE_CURRENT | REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(bq24022_consumers),
 	.consumer_supplies      = bq24022_consumers,
-- 
1.7.4.4
