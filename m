From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:11 +0100
Subject: [PATCH 14/20] regulator: db8500-prcmu: Set 1.8V as a fixed voltage
 for vsmps2
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-15-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This regulator is used for system IO and is fixed to 1.8V. Let's give
consumers the option to fetch the voltage level.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Hi Mark and Liam,

Then intent is to merge this complete patchset all together to not break
anything. Thus I only request for an ack for this particular patch.

Kind regards
Ulf Hansson 

---
 drivers/regulator/db8500-prcmu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 846acf2..617c1ad 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -263,6 +263,8 @@ dbx500_regulator_info[DB8500_NUM_REGULATORS] = {
 			.ops	= &db8500_regulator_ops,
 			.type	= REGULATOR_VOLTAGE,
 			.owner	= THIS_MODULE,
+			.fixed_uV = 1800000,
+			.n_voltages = 1,
 		},
 		.exclude_from_power_state = true,
 	},
-- 
1.7.9.5
