From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 13 Feb 2018 01:53:10 +0800
Subject: [RFC PATCH asoc] ASoC: uniphier: aiodma_rb_get_rp() can be static
In-Reply-To: <201802130150.A223WMAh%fengguang.wu@intel.com>
References: <201802130150.A223WMAh%fengguang.wu@intel.com>
Message-ID: <20180212175310.GA13659@lkp-wsm-ep1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: f37fe2f9987b ("ASoC: uniphier: add support for UniPhier AIO common driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 aio-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 7e9451c..1e5f053 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -904,7 +904,7 @@ void aiodma_ch_set_enable(struct uniphier_aio_sub *sub, int enable)
 	}
 }
 
-u64 aiodma_rb_get_rp(struct uniphier_aio_sub *sub)
+static u64 aiodma_rb_get_rp(struct uniphier_aio_sub *sub)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	u32 pos_u, pos_l;
