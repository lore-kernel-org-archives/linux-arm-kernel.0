From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 16 Mar 2015 16:03:12 -0500 (CDT)
Subject: [GIT PULL] qcom SoC changes for v4.1
Message-ID: <alpine.DEB.2.02.1503161601450.30317@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-4.1

for you to fetch changes up to e5fdad68d47ed344832b7ca4e18b2e9708d8141e:

   soc: qcom: gsbi: Add support for ADM CRCI muxing (2015-03-11 15:18:39 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.1

* Merged the based Qualcomm SCM and SCM boot support
* Cleaned up SCM interface to only expose functional SCM APIs
* Moved Qualcomm SCM code into drivers/firmware
* Updated the SCM APIs for setting cpu cold and warm boot addresses
* Added support for ADM CRCI muxing

----------------------------------------------------------------
Andy Gross (1):
       soc: qcom: gsbi: Add support for ADM CRCI muxing

Kumar Gala (4):
       ARM: qcom: Merge scm and scm boot code together
       ARM: qcom: Cleanup scm interface to only export what is needed
       ARM: qcom: Prep scm code for move to drivers/firmware
       firmware: qcom: scm: Move the scm driver to drivers/firmware

Lina Iyer (3):
       firmware: qcom: scm: Clean cold boot entry to export only the API
       firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
       firmware: qcom: scm: Support cpu power down through SCM

  .../devicetree/bindings/soc/qcom/qcom,gsbi.txt     |  30 +-
  MAINTAINERS                                        |   1 +
  arch/arm/Kconfig                                   |   2 +
  arch/arm/mach-qcom/Kconfig                         |   3 -
  arch/arm/mach-qcom/Makefile                        |   3 -
  arch/arm/mach-qcom/platsmp.c                       |  23 +-
  arch/arm/mach-qcom/scm-boot.c                      |  39 --
  arch/arm/mach-qcom/scm-boot.h                      |  26 --
  arch/arm/mach-qcom/scm.c                           | 326 --------------
  arch/arm/mach-qcom/scm.h                           |  25 --
  drivers/firmware/Kconfig                           |   4 +
  drivers/firmware/Makefile                          |   2 +
  drivers/firmware/qcom_scm.c                        | 494 +++++++++++++++++++++
  drivers/soc/qcom/Kconfig                           |   1 +
  drivers/soc/qcom/qcom_gsbi.c                       | 152 +++++++
  include/linux/qcom_scm.h                           |  28 ++
  16 files changed, 708 insertions(+), 451 deletions(-)
  delete mode 100644 arch/arm/mach-qcom/scm-boot.c
  delete mode 100644 arch/arm/mach-qcom/scm-boot.h
  delete mode 100644 arch/arm/mach-qcom/scm.c
  delete mode 100644 arch/arm/mach-qcom/scm.h
  create mode 100644 drivers/firmware/qcom_scm.c
  create mode 100644 include/linux/qcom_scm.h

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
