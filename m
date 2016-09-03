From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  2 Sep 2016 22:56:04 -0500
Subject: [GIT PULL] Qualcomm Driver Updates for v4.9
Message-ID: <1472874964-17800-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.9

for you to fetch changes up to 23c282d62f573263db679e6b4c9f2da82aa24f96:

  rtc: rtc-pm8xxx: Add support for pm8018 rtc (2016-09-02 13:44:16 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.9

* Silence smem probe defer messages
* Make scm explicitly non-modular
* Assorted SMD bug fixes and minor changes
* Add PM8018 RTC support

----------------------------------------------------------------
Bjorn Andersson (5):
      soc: qcom: smd: Correct compile stub prototypes
      soc: qcom: smd: Simplify multi channel handling
      soc: qcom: smd: Request irqs after parsing properties
      soc: qcom: smd: Represent smd edges as devices
      soc: qcom: smd: Reset rx tail rather than tx

Neil Armstrong (1):
      rtc: rtc-pm8xxx: Add support for pm8018 rtc

Paul Gortmaker (1):
      firmware: qcom_scm: make it explicitly non-modular

Stephen Boyd (1):
      soc: qcom: smem: Silence probe defer error

 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +
 drivers/firmware/qcom_scm.c                        |  19 +-
 drivers/rtc/rtc-pm8xxx.c                           |   1 +
 drivers/soc/qcom/smd.c                             | 265 ++++++++++++---------
 drivers/soc/qcom/smem.c                            |   3 +-
 include/linux/soc/qcom/smd.h                       |  29 ++-
 6 files changed, 191 insertions(+), 127 deletions(-)
