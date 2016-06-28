From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 27 Jun 2016 21:52:43 -0500
Subject: [GIT PULL] Qualcomm Driver Updates for v4.8
Message-ID: <1467082363-22975-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.8

for you to fetch changes up to dd4fe5b292226f2459305965c960d8dc39f36e0f:

  firmware: qcom: scm: Expose PAS command 10 as reset-controller (2016-06-24 22:53:52 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.8

* Rework of SCM driver
* Add file patterns for Qualcomm Maintainers entry
* Add worker for wcnss_ctrl signaling
* Fixes for smp2p
* Update smem_state properties to match documentation
* Add SCM Peripheral Authentication service
* Expose SCM PAS command 10 as a reset controller

----------------------------------------------------------------
Andy Gross (4):
      firmware: qcom: scm: Convert SCM to platform driver
      firmware: qcom: scm: Use atomic SCM for cold boot
      firmware: qcom: scm: Generalize shared error map
      firmware: qcom: scm: Convert to streaming DMA APIS

Bjorn Andersson (6):
      soc: qcom: wcnss_ctrl: Make wcnss_ctrl parent the other components
      soc: qcom: smp2p: Correct addressing of outgoing value
      soc: qcom: smp2p: Drop io-accessors
      soc: qcom: Update properties for smem state referencing
      firmware: qcom: scm: Peripheral Authentication Service
      firmware: qcom: scm: Expose PAS command 10 as reset-controller

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for qcom device tree bindings

Kumar Gala (1):
      firmware: qcom: scm: Add support for ARM64 SoCs

 .../devicetree/bindings/soc/qcom/qcom,smp2p.txt    |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,smsm.txt     |   4 +-
 MAINTAINERS                                        |   1 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/qcom_scm-32.c                     | 327 +++++++++++--------
 drivers/firmware/qcom_scm-64.c                     | 307 +++++++++++++++++-
 drivers/firmware/qcom_scm.c                        | 345 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.h                        |  47 ++-
 drivers/soc/qcom/smem_state.c                      |  12 +-
 drivers/soc/qcom/smp2p.c                           |   7 +-
 drivers/soc/qcom/smsm.c                            |   2 +-
 drivers/soc/qcom/wcnss_ctrl.c                      | 125 ++++++--
 include/linux/qcom_scm.h                           |   8 +
 include/linux/soc/qcom/wcnss_ctrl.h                |   8 +
 14 files changed, 1012 insertions(+), 186 deletions(-)
 create mode 100644 include/linux/soc/qcom/wcnss_ctrl.h
