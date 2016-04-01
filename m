From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  1 Apr 2016 14:58:33 -0500
Subject: [GIT PULL] Qualcomm SoC Updates for v4.7
Message-ID: <1459540713-6913-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.7

for you to fetch changes up to 028021d29ea069390e1f60c6aa5b3511d218454b:

  soc: qcom: smd: Support opening additional channels (2016-03-30 17:21:12 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.7

* Add stubs for smem_state to fix build issues
* Fix module usage in SPM driver
* Add i2c and spi entries into QCOM MAINTAINERS entry
* Add SMD multi channel support
* Add clks to QCOM MAINTAINERS

----------------------------------------------------------------
Bjorn Andersson (6):
      soc: qcom: smem_state: Add stubs for disabled smem_state
      soc: qcom: smd: Introduce callback setter
      soc: qcom: smd: Split discovery and state change work
      soc: qcom: smd: Refactor channel open and close handling
      soc: qcom: smd: Support multiple channels per sdev
      soc: qcom: smd: Support opening additional channels

Lina Iyer (1):
      drivers: qcom: spm: avoid module usage in non-modular SPM driver

Srinivas Kandagatla (2):
      MAINTAINERS: add qcom i2c and spi drivers to list
      MAINTAINERS: add qcom clocks to the maintainers list

 MAINTAINERS                         |   3 +
 drivers/soc/qcom/smd.c              | 229 +++++++++++++++++++++++++++---------
 drivers/soc/qcom/spm.c              |   8 +-
 include/linux/soc/qcom/smd.h        |   8 +-
 include/linux/soc/qcom/smem_state.h |  35 ++++++
 5 files changed, 220 insertions(+), 63 deletions(-)
