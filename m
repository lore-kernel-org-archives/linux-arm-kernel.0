From: shuah.kh@samsung.com (Shuah Khan)
Date: Mon, 10 Feb 2014 09:12:23 -0700
Subject: [RFT][PATCH 00/12] change drivers power management to use dev_pm_ops 
Message-ID: <cover.1392040064.git.shuah.kh@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change drivers to register pm ops using dev_pm_ops instead of legacy pm_ops.
.pm hooks call existing legacy suspend and resume interfaces by passing in
the right pm state. Bus drivers suspend and resume routines call .pm driver
hooks if found.

Shuah Khan (12):
  arm: change locomo platform and bus power management to use
    dev_pm_ops
  arm: change sa1111 platform and bus power management to use
    dev_pm_ops
  arm: change scoop platform power management to use dev_pm_ops
  drivers/macintosh/adb: change platform power managemnet to use
    dev_pm_ops
  mmc: change au1xmmc platform power management to use dev_pm_ops
  mmc: change bfin_sdh platform power management to use dev_pm_ops
  isa: change isa bus power managemnet to use dev_pm_ops
  mmc: change cb710-mmc platform power management to use dev_pm_ops
  mmc: change msm_sdcc platform power management to use dev_pm_ops
  mmc: change tmio_mmc platform power management to use dev_pm_ops
  drivers/pcmcia: change ds driver power management to use dev_pm_ops
  drivers/s390/crypto: change ap_bus driver power management to use
    dev_pm_ops

 arch/arm/common/locomo.c     |   93 +++++++++++++++++++++++++++++++++++-------
 arch/arm/common/sa1111.c     |   88 +++++++++++++++++++++++++++++++--------
 arch/arm/common/scoop.c      |   44 ++++++++++++++++----
 drivers/base/isa.c           |   30 ++++++++++++--
 drivers/macintosh/adb.c      |   41 ++++++++++++++++---
 drivers/mmc/host/au1xmmc.c   |   43 +++++++++++++++----
 drivers/mmc/host/bfin_sdh.c  |   40 +++++++++++++++---
 drivers/mmc/host/cb710-mmc.c |   37 +++++++++++++++--
 drivers/mmc/host/msm_sdcc.c  |   42 +++++++++++++++----
 drivers/mmc/host/tmio_mmc.c  |   42 +++++++++++++++----
 drivers/pcmcia/ds.c          |   36 +++++++++++++---
 drivers/s390/crypto/ap_bus.c |   30 ++++++++++++--
 12 files changed, 481 insertions(+), 85 deletions(-)

-- 
1.7.10.4
