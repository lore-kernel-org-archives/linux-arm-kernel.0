From: agross@codeaurora.org (Andy Gross)
Date: Thu, 18 Dec 2014 14:59:51 -0600
Subject: [PATCH 0/4] pinctrl: qcom: Add multiple copy support
Message-ID: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add multiple copy support for functions which require additional
mux configurations on specific Qualcomm processor pincontrol blocks.  Functions
which may have multiple copies are slimbus, mi2s, pdm, pcie, and GSBI.

Andy Gross (4):
  pinctrl: qcom: Add multiple copy base support
  pinctrl: qcom: ipq8064: Add multi copy support
  pinctrl: qcom: apq8064: Add multi copy support
  pinctrl: qcom: msm8960: Add multi copy support

 .../bindings/pinctrl/qcom,apq8064-pinctrl.txt      |    3 +-
 .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt      |   16 +-
 .../bindings/pinctrl/qcom,msm8960-pinctrl.txt      |   19 +-
 drivers/pinctrl/qcom/pinctrl-apq8064.c             |   29 ++-
 drivers/pinctrl/qcom/pinctrl-ipq8064.c             |  244 ++++++++++++++------
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   10 +
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    4 +
 drivers/pinctrl/qcom/pinctrl-msm8960.c             |   32 ++-
 8 files changed, 257 insertions(+), 100 deletions(-)

-- 
Qualcomm Innovation Center, Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
