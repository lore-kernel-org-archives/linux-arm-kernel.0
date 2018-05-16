From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 16 May 2018 17:41:11 +0900
Subject: [PATCH] media: helene: fix tuning frequency of satellite
Message-ID: <20180516084111.28618-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes tuning frequency of satellite to kHz. That as same
as terrestrial one.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/media/dvb-frontends/helene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-frontends/helene.c
index 04033f0c278b..0a4f312c4368 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -523,7 +523,7 @@ static int helene_set_params_s(struct dvb_frontend *fe)
 	enum helene_tv_system_t tv_system;
 	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
 	struct helene_priv *priv = fe->tuner_priv;
-	int frequencykHz = p->frequency;
+	int frequencykHz = p->frequency / 1000;
 	uint32_t frequency4kHz = 0;
 	u32 symbol_rate = p->symbol_rate/1000;
 
-- 
2.17.0
