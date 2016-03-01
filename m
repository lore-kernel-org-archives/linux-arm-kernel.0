From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 29 Feb 2016 20:43:43 -0600
Subject: [GIT PULL v2] Qualcomm SoC Updates for 4.6
Message-ID: <1456800223-29655-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.6

for you to fetch changes up to 3a70e3cddc493dca2555e2911f6ee18e1eaefa7f:

  soc: qcom: smp2p: Use memset_io to zero out new entries (2016-02-29 18:02:27 -0600)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.6

* Add stubs for smem_state to fix build issues
* Fix module usage in SPM driver
* Add i2c and spi entries into QCOM MAINTAINERS entry
* Add SMD multi channel support
* Drop ARCH_MSM* configs and fixup clocksource support
* Add clks to QCOM MAINTAINERS
* Fix smp2p memset issue

----------------------------------------------------------------
Bjorn Andersson (7):
      soc: qcom: smem_state: Add stubs for disabled smem_state
      soc: qcom: smd: Introduce callback setter
      soc: qcom: smd: Split discovery and state change work
      soc: qcom: smd: Refactor channel open and close handling
      soc: qcom: smd: Support multiple channels per sdev
      soc: qcom: smd: Support opening additional channels
      soc: qcom: smp2p: Use memset_io to zero out new entries

Lina Iyer (1):
      drivers: qcom: spm: avoid module usage in non-modular SPM driver

Srinivas Kandagatla (2):
      MAINTAINERS: add qcom i2c and spi drivers to list
      MAINTAINERS: add qcom clocks to the maintainers list

Stephen Boyd (2):
      ARM: qcom: Make an option for qcom 'a-family' platforms
      ARM: qcom: Drop ARCH_MSM* configs

 MAINTAINERS                         |   3 +
 arch/arm/Makefile                   |   3 +-
 arch/arm/mach-qcom/Kconfig          |  17 +--
 drivers/soc/qcom/smd.c              | 229 +++++++++++++++++++++++++++---------
 drivers/soc/qcom/smp2p.c            |   2 +-
 drivers/soc/qcom/spm.c              |   8 +-
 include/linux/soc/qcom/smd.h        |   8 +-
 include/linux/soc/qcom/smem_state.h |  35 ++++++
 8 files changed, 231 insertions(+), 74 deletions(-)
