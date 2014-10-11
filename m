From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 11 Oct 2014 21:09:33 +0530
Subject: [PATCH 00/12] dmaengine: remove users of device_control
Message-ID: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent discussion [1] on the API have resulted in moving away from
device_control ioctl method to proper channel APIs.
There are still few users on the device_control which should use the wrappers
existing rather than access device_control.
This will aid us in deprecating and removing device_control, possibly after
the merge window.

These can be merged thru respective subsystem tree or dmaengine tree. Either
way please just let me know.

Feng's kbuild has tested these as well [2]

[1]: http://www.spinics.net/lists/dmaengine/msg02212.html
[2]: http://git.infradead.org/users/vkoul/slave-dma.git/shortlog/refs/heads/topic/dma_control_cleanup

Vinod Koul (12):
  pata_arasan_cf: use dmaengine_terminate_all() API
  dmaengine: coh901318: use dmaengine_terminate_all() API
  [media] V4L2: mx3_camer: use dmaengine_pause() API
  mtd: fsmc_nand: use dmaengine_terminate_all() API
  mtd: sh_flctl: use dmaengine_terminate_all() API
  net: ks8842: use dmaengine_terminate_all() API
  spi/atmel: use dmaengine_terminate_all() API
  spi/spi-dw-mid.c: use dmaengine_slave_config() API
  serial: sh-sci: use dmaengine_terminate_all() API
  usb: musb: ux500_dma: use dmaengine_xxx() APIs
  ASoC: txx9: use dmaengine_terminate_all() API
  video: mx3fb: use dmaengine_terminate_all() API

 drivers/ata/pata_arasan_cf.c                   |    5 ++---
 drivers/dma/coh901318.c                        |    2 +-
 drivers/media/platform/soc_camera/mx3_camera.c |    6 ++----
 drivers/mtd/nand/fsmc_nand.c                   |    2 +-
 drivers/mtd/nand/sh_flctl.c                    |    2 +-
 drivers/net/ethernet/micrel/ks8842.c           |    6 ++----
 drivers/spi/spi-atmel.c                        |    6 ++----
 drivers/spi/spi-dw-mid.c                       |    6 ++----
 drivers/tty/serial/sh-sci.c                    |    2 +-
 drivers/usb/musb/ux500_dma.c                   |    7 ++-----
 drivers/video/fbdev/mx3fb.c                    |    3 +--
 sound/soc/txx9/txx9aclc.c                      |    7 +++----
 12 files changed, 20 insertions(+), 34 deletions(-)
