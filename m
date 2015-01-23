From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 23 Jan 2015 10:37:37 -0600 (CST)
Subject: [GIT PULL] qcom SoC changes for v3.20-2
Message-ID: <alpine.DEB.2.02.1501231035340.27036@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated from the tags/qcom-soc-for-3.20, dropped the movement of scm code 
into drivers/soc/qcom, added a few other minor scm bug fixes, and Andy 
Gross as co-maintainer.

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-3.20-2

for you to fetch changes up to f5d3af9d21f9790ac078276e6c103871c12a3daa:

   MAINTAINERS: Add co-maintainer for ARM/Qualcomm Support (2015-01-23 10:29:21 -0600)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v3.20-2

* Various bug fixes and minor feature additions to scm code
* Added big-endian support to debug MSM uart
* Added big-endian support to ARCH_QCOM
* Cleaned up some Kconfig options associated with ARCH_QCOM
* Added Andy Gross as co-maintainer

----------------------------------------------------------------
Andy Gross (1):
       MAINTAINERS: Add co-maintainer for ARM/Qualcomm Support

Lina Iyer (1):
       ARM: qcom: Add SCM warmboot flags for quad core targets.

Olav Haugan (1):
       ARM: qcom: scm: Add logging of actual return code from scm call

Stephen Boyd (8):
       ARM: debug: Update MSM and QCOM DEBUG_LL help
       ARM: debug: msm: Support big-endian CPUs
       ARM: qcom: Select ARCH_SUPPORTS_BIG_ENDIAN
       ARM: qcom: scm: Fix incorrect cache invalidation
       ARM: qcom: scm: Get cacheline size from CTR
       ARM: qcom: scm: Clarify boot interface
       ARM: qcom: Fix SCM interface for big-endian kernels
       ARM: qcom: Drop unnecessary selects from ARCH_QCOM

Vikram Mulukutla (1):
       ARM: qcom: scm: Flush the command buffer only instead of the entire cache

  MAINTAINERS                   |  3 ++
  arch/arm/Kconfig.debug        |  5 ++-
  arch/arm/include/debug/msm.S  |  6 +++
  arch/arm/mach-qcom/Kconfig    |  3 +-
  arch/arm/mach-qcom/scm-boot.c | 10 ++---
  arch/arm/mach-qcom/scm-boot.h |  4 +-
  arch/arm/mach-qcom/scm.c      | 85 ++++++++++++++++++++++++++++---------------
  7 files changed, 77 insertions(+), 39 deletions(-)

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
