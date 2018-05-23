From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 23 May 2018 09:27:50 +0900
Subject: [PATCH v3 2/2] media: helene: support IF frequency of ISDB-S
In-Reply-To: <20180523002750.27136-1-suzuki.katsuhiro@socionext.com>
References: <20180523002750.27136-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180523002750.27136-2-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enhances maximum IF frequency to 2.072GHz of this tuner
for supporting ISDB-S in Japan.

Maimum RF center frequency of ISDB-S for right-handed circularly
polarized.
  BSAT
    BS-23 12.14944GHz
  N-SAT-110
    ND-24 12.731GHz

Local frequency of BS/CS converter is typically 10.678GHz.

---

Changes since v2:
  - Newly added

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/media/dvb-frontends/helene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-frontends/helene.c
index 04033f0c278b..7d02a9ea7d95 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -874,7 +874,7 @@ static const struct dvb_tuner_ops helene_tuner_ops_s = {
 	.info = {
 		.name = "Sony HELENE Sat tuner",
 		.frequency_min = 500000,
-		.frequency_max = 2500000,
+		.frequency_max = 2072000000,
 		.frequency_step = 1000,
 	},
 	.init = helene_init,
@@ -888,7 +888,7 @@ static const struct dvb_tuner_ops helene_tuner_ops = {
 	.info = {
 		.name = "Sony HELENE Sat/Ter tuner",
 		.frequency_min = 500000,
-		.frequency_max = 1200000000,
+		.frequency_max = 2072000000,
 		.frequency_step = 1000,
 	},
 	.init = helene_init,
-- 
2.17.0
