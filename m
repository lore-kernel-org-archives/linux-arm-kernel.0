From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 25 Jun 2018 15:31:04 +0100
Subject: [PATCH 00/11] ASoC: qdsp6: Fix dt based module loading
Message-ID: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent discussion on https://lkml.org/lkml/2018/6/18/1282 suggested
that qdsp6 code is using less common of_platform apis which would
not give dt based module loading support.

Suggestion from Rob was to add compatible strings to the dais nodes
This patchset adds this. Also this patchset has 2 trivial fixes which
is removing redundant owner and fix a error check in q6routing.

Thanks,
srini

Srinivas Kandagatla (11):
  ASoC: q6adm: dt-bindings: add compatible string to routing
  ASoC: q6asm: dt-bindings: add compatible string to dais
  ASoC: q6afe: dt-bindings: add compatible string to dais
  ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6afe-dai: support dt based module loading
  ASoC: qdsp6: q6asm-dai: support dt based module loading
  ASoC: qdsp6: q6routing: support dt based module loading
  ASoC: qcom: apq8096: remove redundant owner assignment
  ASoC: qdsp6: q6routing: add proper error check

 Documentation/devicetree/bindings/sound/qcom,q6adm.txt |  6 ++++++
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt |  6 ++++++
 Documentation/devicetree/bindings/sound/qcom,q6asm.txt |  6 ++++++
 sound/soc/qcom/apq8096.c                               |  1 -
 sound/soc/qcom/qdsp6/q6adm.c                           | 15 ++-------------
 sound/soc/qcom/qdsp6/q6afe-dai.c                       |  8 ++++++++
 sound/soc/qcom/qdsp6/q6afe.c                           | 16 ++--------------
 sound/soc/qcom/qdsp6/q6asm-dai.c                       |  8 ++++++++
 sound/soc/qcom/qdsp6/q6asm.c                           | 17 ++---------------
 sound/soc/qcom/qdsp6/q6routing.c                       | 10 +++++++++-
 10 files changed, 49 insertions(+), 44 deletions(-)

-- 
2.16.2
