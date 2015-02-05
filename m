From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Feb 2015 01:03:52 +0800
Subject: [PATCH baohua] ASoC: sirf: atlas7: atlas7_iacc_dai_ops can be static
In-Reply-To: <201502060130.hszyNa1F%fengguang.wu@intel.com>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com>
Message-ID: <20150205170352.GA49811@snb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 atlas7-iacc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sirf/atlas7-iacc.c b/sound/soc/sirf/atlas7-iacc.c
index ca17e90..a359d8b 100644
--- a/sound/soc/sirf/atlas7-iacc.c
+++ b/sound/soc/sirf/atlas7-iacc.c
@@ -165,7 +165,7 @@ static int atlas7_iacc_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-struct snd_soc_dai_ops atlas7_iacc_dai_ops = {
+static struct snd_soc_dai_ops atlas7_iacc_dai_ops = {
 	.hw_params = atlas7_iacc_hw_params,
 	.trigger = atlas7_iacc_trigger,
 };
