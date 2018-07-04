From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jul 2018 10:49:38 +0100
Subject: [PATCH 0/6] ASoC: qdsp6: Add missing slimbus capture support
Message-ID: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support to slimbus tx ports plus 3 trival fixes
to do with closing port when its not really open.
slim tx support invoving add dais and routing, rest of the dsp
configuration commands are already available in mainline.

slim tx is verified with wcd9335 codec on DB820c.

Thanks,
srini

Srinivas Kandagatla (6):
  ASoC: qdsp6: q6afe: Add missing slimbus capture ports
  ASoC: qdsp6: q6afe-dai: add support to slim tx dais
  ASoC: qdsp6: q6routing: add slim rx routings
  ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai num_channels
  ASoC: qdsp6: q6afe-dai: do not close port if its not opened
  ASoC: qdsp6: q6asm-dai: do not close port if its not opened

 sound/soc/qcom/qdsp6/q6afe-dai.c | 179 +++++++++++++++++++++++++++++++++++----
 sound/soc/qcom/qdsp6/q6afe.c     |  21 +++++
 sound/soc/qcom/qdsp6/q6asm-dai.c |   4 +-
 sound/soc/qcom/qdsp6/q6routing.c |  28 ++++++
 4 files changed, 216 insertions(+), 16 deletions(-)

-- 
2.16.2
