From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 25 May 2018 17:33:44 -0500
Subject: [GIT PULL] Qualcomm Driver updates for 4.18 - RESEND
Message-ID: <1527287624-26491-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.18

for you to fetch changes up to 6d361c1db7b69fddf5748cf212169ab57bb13a6e:

  soc: qcom: smem: introduce qcom_smem_virt_to_phys() (2018-05-25 15:53:59 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.18

* Various SMEM updates/fixes
* Add qcom_smem_virt_to_phys SMEM API
* Update MAINTAINERS to include qcom_scm pattern
* Add Qualcomm Command DB driver
* Add Qualcomm SCM compatible for IPQ4019
* Add MSM8998 to smd-rpm compatible list
* Add Qualcomm GENI based QUP wrapper
* Fix Qualcomm QMI buffer sizing bug

----------------------------------------------------------------
Alex Elder (8):
      soc: qcom: smem: fix first cache entry calculation
      soc: qcom: smem: return proper type for cached entry functions
      soc: qcom: smem: byte swap values properly
      soc: qcom: smem: fix off-by-one error in qcom_smem_alloc_private()
      soc: qcom: smem: fix qcom_smem_set_global_partition()
      soc: qcom: smem: check sooner in qcom_smem_set_global_partition()
      soc: qcom: qmi: fix a buffer sizing bug
      soc: qcom: smem: introduce qcom_smem_virt_to_phys()

Bjorn Andersson (1):
      soc: qcom: smd-rpm: Add msm8998 compatible

Guenter Roeck (1):
      soc: Unconditionally include qcom Makefile

Karthikeyan Ramasubramanian (1):
      soc: qcom: Add GENI based QUP Wrapper driver

Mahesh Sivasubramanian (1):
      drivers: qcom: add command DB driver

Niklas Cassel (1):
      MAINTAINERS: Update pattern for qcom_scm

Sricharan R (1):
      firmware: qcom: scm: Add ipq4019 soc compatible

Stephen Boyd (1):
      soc: qcom: cmd-db: Make endian-agnostic

 .../devicetree/bindings/firmware/qcom,scm.txt      |   3 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   1 +
 MAINTAINERS                                        |   2 +-
 drivers/firmware/qcom_scm.c                        |   3 +
 drivers/of/platform.c                              |   1 +
 drivers/soc/Makefile                               |   2 +-
 drivers/soc/qcom/Kconfig                           |  18 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/cmd-db.c                          | 317 +++++++++
 drivers/soc/qcom/qcom-geni-se.c                    | 748 +++++++++++++++++++++
 drivers/soc/qcom/qmi_interface.c                   |   5 +-
 drivers/soc/qcom/smd-rpm.c                         |   1 +
 drivers/soc/qcom/smem.c                            |  77 ++-
 include/linux/qcom-geni-se.h                       | 425 ++++++++++++
 include/linux/soc/qcom/smem.h                      |   2 +
 include/soc/qcom/cmd-db.h                          |  45 ++
 16 files changed, 1625 insertions(+), 27 deletions(-)
 create mode 100644 drivers/soc/qcom/cmd-db.c
 create mode 100644 drivers/soc/qcom/qcom-geni-se.c
 create mode 100644 include/linux/qcom-geni-se.h
 create mode 100644 include/soc/qcom/cmd-db.h
