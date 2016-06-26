From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sat, 25 Jun 2016 22:21:30 -0700
Subject: [PATCH 0/2] Support HSIC "pins" on msm8974 tlmm
Message-ID: <20160626052132.7178-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of a larger patch series that adds support for the
USB HSIC controller on msm8974 based SoCs. The first patch here
is a minor fix for a problem that isn't happening yet but could
happen in the future. The second patch adds an hsic pin so
we can configure the hsic bits that live in the TLMM register
space.

Stephen Boyd (2):
  pinctrl: qcom: Clear all function selection bits
  pinctrl: qcom: msm8974: Add hsic_ctl pinmux

 .../bindings/pinctrl/qcom,msm8974-pinctrl.txt      |  5 ++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  6 ++-
 drivers/pinctrl/qcom/pinctrl-msm8x74.c             | 43 +++++++++++++++++++++-
 3 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.9.0.rc2.8.ga28705d
