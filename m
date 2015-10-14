From: agross@codeaurora.org (Andy Gross)
Date: Wed, 14 Oct 2015 15:57:16 -0500
Subject: [GIT PULL] qcom SoC changes for 4.4
Message-ID: <1444856236-32260-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git at git.codeaurora.org:quic/kernel/agross-msm.git tags/qcom-soc-for-4.4

for you to fetch changes up to d0bfd7c9b162612de55ca2d204403b90dc278db6:

  soc: qcom: smem: Move RPM message ram out of smem DT node (2015-10-14 14:51:40 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for 4.4

* Implement id_table driver matching in SMD
* Avoid NULL pointer exception on remove of SMEM
* Reorder SMEM/SMD configs
* Make qcom_smem_get() return a pointer
* Handle big endian CPUs correctly in SMEM
* Represent SMD channel layout in structures
* Use __iowrite32_copy() in SMD
* Remove use of VLAIs in SMD
* Handle big endian CPUs correctly in SMD/RPM
* Handle big endian CPUs corretly in SMD
* Reject sending SMD packets that are too large
* Fix endianness issue in SCM __qcom_scm_is_call_available
* Add missing prototype for qcom_scm_is_available()
* Correct SMEM items for upper channels
* Use architecture level to build SCM correctly
* Delete unneeded of_node_put in SMD
* Correct active/slep state flagging in SMD/RPM
* Move RPM message ram out of SMEM DT node

----------------------------------------------------------------
Andy Gross (2):
      firmware: qcom: scm: Add function stubs for ARM64
      Merge tag 'qcom-fixes-for-4.3-rc1' into base-for-4.4

Arnd Bergmann (1):
      firmware: qcom-scm: build for correct architecture level

Bjorn Andersson (4):
      soc: qcom: smd: Implement id_table driver matching
      soc: qcom: smd: Reject send of too big packets
      soc: qcom: smd: Correct SMEM items for upper channels
      soc: qcom: smd-rpm: Correct the active vs sleep state flagging

Julia Lawall (1):
      soc: qcom: smd: delete unneeded of_node_put

Rob Clark (2):
      qcom-scm: fix endianess issue in __qcom_scm_is_call_available
      qcom-scm: add missing prototype for qcom_scm_is_available()

Stephen Boyd (10):
      soc: qcom: smem: Avoid NULL pointer exception on remove
      soc: qcom: Reorder SMEM/SMD configs
      soc: qcom: Make qcom_smem_get() return a pointer
      soc: qcom: smem: Handle big endian CPUs
      soc: qcom: smd: Represent channel layout in structures
      soc: qcom: smd: Use __iowrite32_copy() instead of open-coding it
      soc: qcom: smd: Remove use of VLAIS
      soc: qcom: smd_rpm: Handle big endian CPUs
      soc: qcom: smd: Handle big endian CPUs
      soc: qcom: smem: Move RPM message ram out of smem DT node

 arch/arm/boot/dts/qcom-msm8974.dtsi |   17 +-
 drivers/firmware/Kconfig            |    8 +
 drivers/firmware/Makefile           |    5 +-
 drivers/firmware/qcom_scm-32.c      |    6 +-
 drivers/firmware/qcom_scm-64.c      |   63 ++++++
 drivers/soc/qcom/Kconfig            |   16 +-
 drivers/soc/qcom/smd-rpm.c          |   68 ++++---
 drivers/soc/qcom/smd.c              |  296 +++++++++++++++++-----------
 drivers/soc/qcom/smem.c             |  368 +++++++++++++++++++----------------
 include/linux/qcom_scm.h            |    2 +
 include/linux/soc/qcom/smd.h        |   11 ++
 include/linux/soc/qcom/smem.h       |    2 +-
 12 files changed, 525 insertions(+), 337 deletions(-)
 create mode 100644 drivers/firmware/qcom_scm-64.c
