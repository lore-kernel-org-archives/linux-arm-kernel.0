From: green@linuxhacker.ru (green at linuxhacker.ru)
Date: Sun,  8 May 2011 17:50:07 -0400
Subject: [PATCH 2/2] Add tps65921 chip
In-Reply-To: <1304891407-29364-1-git-send-email-green@linuxhacker.ru>
References: <1304891407-29364-1-git-send-email-green@linuxhacker.ru>
Message-ID: <1304891407-29364-3-git-send-email-green@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Drokin <green@linuxhacker.ru>

Very similar to TPS65920
List of differences: http://www.ti.com/litv/pdf/swcu066b

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 drivers/mfd/twl-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 960b5be..3daebcc 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1107,6 +1107,8 @@ static const struct i2c_device_id twl_ids[] = {
 	{ "tps65950", 0 },		/* catalog version of twl5030 */
 	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
 	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
+	{ "tps65921", TPS_SUBSET },	/* fewer LDOs; no codec, no LED
+					   and vibrator. Charger in USB module*/
 	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
 	{ /* end of list */ },
 };
-- 
1.7.4.4
