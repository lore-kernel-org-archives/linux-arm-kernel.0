From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 21 Jul 2018 23:10:21 -0500
Subject: [GIT PULL] Qualcomm Driver updates for 4.19
In-Reply-To: <1532232622-18275-1-git-send-email-andy.gross@linaro.org>
References: <1532232622-18275-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1532232622-18275-4-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.19

for you to fetch changes up to 78ee559d7fc65e37670a46cfbeaaa62cb014af67:

  soc: qcom: rmtfs-mem: fix memleak in probe error paths (2018-07-21 14:53:47 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.19

* Add Qualcomm LLCC driver
* Add Qualcomm RPMH controller
* Fix memleak in Qualcomm RMTFS
* Add dummy qcom_scm_assign_mem()
* Fix check for global partition in SMEM

----------------------------------------------------------------
Bjorn Andersson (1):
      soc: qcom: smem: Correct check for global partition

Douglas Anderson (1):
      drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help children

Johan Hovold (1):
      soc: qcom: rmtfs-mem: fix memleak in probe error paths

Lina Iyer (10):
      drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
      dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
      drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
      drivers: qcom: rpmh: add RPMH helper functions
      drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
      drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
      drivers: qcom: rpmh: cache sleep/wake state requests
      drivers: qcom: rpmh: allow requests to be sent asynchronously
      drivers: qcom: rpmh: add support for batch RPMH request
      drivers: qcom: rpmh-rsc: allow active requests from wake TCS

Niklas Cassel (2):
      firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
      soc: qcom: llc-slice: Add missing MODULE_LICENSE()

Raju P.L.S.S.S.N (2):
      drivers: qcom: rpmh-rsc: fix the loop index check in get_req_from_tcs
      drivers: qcom: rpmh: fix unwanted error check for get_tcs_of_type()

Rishabh Bhatnagar (2):
      dt-bindings: Documentation for qcom, llcc
      drivers: soc: Add LLCC driver

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  26 +
 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      | 137 ++++
 drivers/soc/qcom/Kconfig                           |  27 +
 drivers/soc/qcom/Makefile                          |   6 +
 drivers/soc/qcom/llcc-sdm845.c                     |  94 +++
 drivers/soc/qcom/llcc-slice.c                      | 338 ++++++++++
 drivers/soc/qcom/rmtfs_mem.c                       |   3 +-
 drivers/soc/qcom/rpmh-internal.h                   | 114 ++++
 drivers/soc/qcom/rpmh-rsc.c                        | 693 +++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                            | 513 +++++++++++++++
 drivers/soc/qcom/smem.c                            |  10 +-
 drivers/soc/qcom/trace-rpmh.h                      |  82 +++
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 +
 include/linux/qcom_scm.h                           |   4 +
 include/linux/soc/qcom/llcc-qcom.h                 | 180 ++++++
 include/soc/qcom/rpmh.h                            |  51 ++
 include/soc/qcom/tcs.h                             |  56 ++
 17 files changed, 2341 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 drivers/soc/qcom/rpmh-internal.h
 create mode 100644 drivers/soc/qcom/rpmh-rsc.c
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 drivers/soc/qcom/trace-rpmh.h
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h
 create mode 100644 include/soc/qcom/rpmh.h
 create mode 100644 include/soc/qcom/tcs.h
