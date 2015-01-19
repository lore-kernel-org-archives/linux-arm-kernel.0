From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 19 Jan 2015 12:27:15 -0600 (CST)
Subject: [GIT PULL] qcom SoC changes for v3.20
Message-ID: <alpine.DEB.2.02.1501191226010.2973@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-3.20

for you to fetch changes up to ae0a6075c046f9c8dbac18f53a779592f97b402e:

   soc: qcom: scm: Clarify boot interface (2015-01-19 11:55:12 -0600)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v3.20

* Moved scm support into drivers/soc/qcom (allows for use by drivers)
* Various bug fixes and minor feature additions to scm code
* Added big-endian support to debug MSM uart
* Added big-endian support to ARCH_QCOM

----------------------------------------------------------------
Lina Iyer (2):
       ARM: qcom: Add SCM warmboot flags for quad core targets.
       soc: qcom: scm: Move scm-boot files to drivers/soc and include/soc

Olav Haugan (1):
       ARM: qcom: scm: Add logging of actual return code from scm call

Saravana Kannan (1):
       ARM: qcom: scm: Add API to query for service/command availability.

Stephen Boyd (9):
       ARM: debug: Update MSM and QCOM DEBUG_LL help
       ARM: debug: msm: Support big-endian CPUs
       ARM: qcom: Select ARCH_SUPPORTS_BIG_ENDIAN
       ARM: qcom: scm: Fix incorrect cache invalidation
       ARM: qcom: scm: Get cacheline size from CTR
       ARM: qcom: scm: Add a feat version query API
       soc: qcom: scm: Move the scm driver to drivers/soc/qcom
       soc: qcom: scm: Add atomic SCM APIs
       soc: qcom: scm: Clarify boot interface

Vikram Mulukutla (1):
       ARM: qcom: scm: Flush the command buffer only instead of the entire cache

  arch/arm/Kconfig.debug                             |   5 +-
  arch/arm/include/debug/msm.S                       |   6 +
  arch/arm/mach-qcom/Kconfig                         |   4 +-
  arch/arm/mach-qcom/Makefile                        |   3 -
  arch/arm/mach-qcom/platsmp.c                       |   2 +-
  drivers/soc/qcom/Kconfig                           |   2 +
  drivers/soc/qcom/Makefile                          |   2 +
  .../arm/mach-qcom => drivers/soc/qcom}/scm-boot.c  |   6 +-
  {arch/arm/mach-qcom => drivers/soc/qcom}/scm.c     | 162 ++++++++++++++++++---
  .../arm/mach-qcom => include/soc/qcom}/scm-boot.h  |   4 +-
  {arch/arm/mach-qcom => include/soc/qcom}/scm.h     |   8 +-
  11 files changed, 173 insertions(+), 31 deletions(-)
  rename {arch/arm/mach-qcom => drivers/soc/qcom}/scm-boot.c (91%)
  rename {arch/arm/mach-qcom => drivers/soc/qcom}/scm.c (62%)
  rename {arch/arm/mach-qcom => include/soc/qcom}/scm-boot.h (87%)
  rename {arch/arm/mach-qcom => include/soc/qcom}/scm.h (70%)

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
