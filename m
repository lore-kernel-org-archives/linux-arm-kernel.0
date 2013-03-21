From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:18 +0000
Subject: [PATCH 21/46] regulator: ab8500: Correct TVOUT regulator start-up
 delay
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-22-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Update TVOUT regulator to match specification. (Was 10ms,
changed to 500us.)

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bengt JONSSON <bengt.g.jonsson@stericsson.com>
---
 drivers/regulator/ab8500.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index a1b1a48..3dff117 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -484,9 +484,9 @@ static struct ab8500_regulator_info
 			.owner		= THIS_MODULE,
 			.n_voltages	= 1,
 			.min_uV		= 2000000,
-			.enable_time	= 10000,
+			.enable_time	= 500,
 		},
-		.delay			= 10000,
+		.delay			= 500,
 		.load_lp_uA		= 1000,
 		.update_bank		= 0x03,
 		.update_reg		= 0x80,
-- 
1.7.10.4
