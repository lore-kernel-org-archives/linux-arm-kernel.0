From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:17:40 +0100
Subject: [PATCH 0/7] [media] ARM randconfig fixes
Message-ID: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

This is one set of randconfig fixes that I've been carrying in
a local branch for a long time. I have made sure that they are
all still required, but there are others that I have not been
able to reproduce yet, so I will probably send them out once
I get the errors again.

The ones here are all trivial, mostly adding missing dependencies.

Please apply.

Arnd Bergmann (7):
  [media] timberdale: do not select TIMB_DMA
  [media] radio/aimslab: use mdelay instead of udelay
  [media] staging/davinci/vpfe/dm365: add missing dependencies
  [media] siano: fix Kconfig dependencies
  [media] gspca: add INPUT dependency
  [media] marvell-ccic: MMP_CAMERA never worked
  [media] marvell-ccic needs VIDEOBUF2_DMA_SG

 drivers/media/mmc/siano/Kconfig             | 2 ++
 drivers/media/platform/Kconfig              | 6 ++----
 drivers/media/platform/marvell-ccic/Kconfig | 3 ++-
 drivers/media/radio/radio-aimslab.c         | 4 ++--
 drivers/media/usb/gspca/Kconfig             | 1 +
 drivers/media/usb/siano/Kconfig             | 2 ++
 drivers/staging/media/davinci_vpfe/Kconfig  | 2 ++
 7 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.1.0.rc2
