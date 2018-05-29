From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 29 May 2018 11:18:27 +0100
Subject: [PATCH 0/6] ASoC: qdsp6: Add support to TDM ports
Message-ID: <20180529101833.30489-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds supports to 40 TDM ports available in q6AFE module.

Among these 6 patches, there are 2 cleanup patches, first one which
makes i2s use common prepare function and the second one is add
macros for routings to make it easy to add new port routings.
Rest of the 4 patches are tdm dt-bindings, afe port prepare support
in afe, afe-dais support and adding tdm routing update.

These patches have been tested by Rohit on SDM845.

Thanks,
Srini

Srinivas Kandagatla (6):
  ASoC: qdsp6: dt-bindings: Add q6afe tdm dt binding
  ASoC: qdsp6: qdafe: add support to tdm ports
  ASoC: qdsp6: q6afe-dai: use q6afe_dai_prepare() for MI2S
  ASoC: qdsp6: q6afe-dai: add support to tdm dais
  ASoC: qdsp6: q6routing: Add macros for mixers
  ASoC: qdsp6: q6routing: Add support to all TDM Mixers

 .../devicetree/bindings/sound/qcom,q6afe.txt       |   68 ++
 include/dt-bindings/sound/qcom,q6afe.h             |   80 ++
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  621 ++++++++++-
 sound/soc/qcom/qdsp6/q6afe.c                       |  429 +++++++-
 sound/soc/qcom/qdsp6/q6afe.h                       |   20 +-
 sound/soc/qcom/qdsp6/q6routing.c                   | 1084 ++++++++++----------
 6 files changed, 1733 insertions(+), 569 deletions(-)

-- 
2.16.2
