From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 17 Dec 2015 14:33:55 -0600
Subject: [GIT PULL] Qualcomm SoC Updates for 4.5
Message-ID: <1450384435-4300-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.5

for you to fetch changes up to bbeaa59598cae12626c9c42e91821e3abd5b87f0:

  MAINTAINERS: Change QCOM entries (2015-12-17 13:55:38 -0600)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for 4.5

* Add WCNSS_CTRL client
* Various Kconfig changes to fix build issues
* Update SoC Qualcomm MAINTAINERS entry
* Add SMP2P, SMSM, and SMEM state machine drivers
* Add SMD-RPM support for existing platforms

----------------------------------------------------------------
Andy Gross (2):
      soc: qcom: smd-rpm: Add existing platform support
      MAINTAINERS: Change QCOM entries

Arnd Bergmann (2):
      soc: qcom: enable smsm/smp2p modular build
      ARM: qcom: select ARM_CPU_SUSPEND for power management

Bjorn Andersson (5):
      soc: qcom: Introduce common SMEM state machine code
      soc: qcom: smsm: Add driver for Qualcomm SMSM
      soc: qcom: smp2p: Qualcomm Shared Memory Point to Point
      MAINTAINERS: Add rules for Qualcomm dts files
      soc: qcom: Introduce WCNSS_CTRL SMD client

Stephen Boyd (1):
      serial: msm_serial: Make config tristate

 MAINTAINERS                         |   8 +-
 drivers/soc/qcom/Kconfig            |  27 ++
 drivers/soc/qcom/Makefile           |   4 +
 drivers/soc/qcom/smd-rpm.c          |   2 +
 drivers/soc/qcom/smem_state.c       | 201 ++++++++++++
 drivers/soc/qcom/smp2p.c            | 578 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/smsm.c             | 625 ++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/wcnss_ctrl.c       | 272 ++++++++++++++++
 drivers/tty/serial/Kconfig          |   2 +-
 include/linux/soc/qcom/smem_state.h |  18 ++
 10 files changed, 1733 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/qcom/smem_state.c
 create mode 100644 drivers/soc/qcom/smp2p.c
 create mode 100644 drivers/soc/qcom/smsm.c
 create mode 100644 drivers/soc/qcom/wcnss_ctrl.c
 create mode 100644 include/linux/soc/qcom/smem_state.h
