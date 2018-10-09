From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 09 Oct 2018 11:51:46 +0200
Subject: [GIT PULL] Reset controller changes for v4.20
Message-ID: <1539078706.6678.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.20

for you to fetch changes up to b790c8ea5593d6dc3580adfad8e117eeb56af874:

  reset: Fix potential use-after-free in __of_reset_control_get() (2018-10-08 15:25:21 +0200)

----------------------------------------------------------------
Reset controller changes for v4.20

This adds a new driver for the PDC Global (Power Domain Controller)
reset controller found on Qualcomm SDM845 SoCs, fixes a potential
use-after-free issue in reset_controller_dev.of_xlate() callbacks
from __of_reset_control_get(), and trivially fixes a documentation
grammar issue.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      reset: Grammar s/more then once/more than once/
      reset: Fix potential use-after-free in __of_reset_control_get()

Sibi Sankar (2):
      dt-bindings: reset: Add PDC Global binding for SDM845 SoCs
      reset: qcom: PDC Global (Power Domain Controller) reset controller

 .../devicetree/bindings/reset/qcom,pdc-global.txt  |  52 +++++++++
 drivers/reset/Kconfig                              |   9 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  15 +--
 drivers/reset/reset-qcom-pdc.c                     | 124 +++++++++++++++++++++
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |  20 ++++
 include/linux/reset.h                              |   2 +-
 7 files changed, 215 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
 create mode 100644 drivers/reset/reset-qcom-pdc.c
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
