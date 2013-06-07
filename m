From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Jun 2013 17:11:28 +0100
Subject: [PATCH 10/10] regulator: ab8500: Provide supply names for the AUX
 regulators
In-Reply-To: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370621488-18130-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms the AUX[1|2|3] regulators are supplied voltage by
a separate regulator. For example on Snowball these are provided by
the EXT3. If we list them here, we can supply voltage to them by
simply listing them in as a consumer of EXT3 in the Snowball case.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index aea9fdae..603f192 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -719,6 +719,7 @@ static struct ab8500_regulator_info
 			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
 			.volt_table	= ldo_vauxn_voltages,
 			.enable_time	= 200,
+			.supply_name    = "vin",
 		},
 		.load_lp_uA		= 5000,
 		.update_bank		= 0x04,
@@ -741,6 +742,7 @@ static struct ab8500_regulator_info
 			.n_voltages	= ARRAY_SIZE(ldo_vauxn_voltages),
 			.volt_table	= ldo_vauxn_voltages,
 			.enable_time	= 200,
+			.supply_name    = "vin",
 		},
 		.load_lp_uA		= 5000,
 		.update_bank		= 0x04,
@@ -763,6 +765,7 @@ static struct ab8500_regulator_info
 			.n_voltages	= ARRAY_SIZE(ldo_vaux3_voltages),
 			.volt_table	= ldo_vaux3_voltages,
 			.enable_time	= 450,
+			.supply_name    = "vin",
 		},
 		.load_lp_uA		= 5000,
 		.update_bank		= 0x04,
-- 
1.7.10.4
