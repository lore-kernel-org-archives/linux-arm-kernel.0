From: oliver@schinagl.nl (Olliver Schinagl)
Date: Tue, 19 Apr 2016 09:12:12 +0200
Subject: [PATCHv1 0/2] mmc: Move broken-hpi also to the chipset level
Message-ID: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few months ago, hans de Goede and I where talking about the behavior of HPI on
eMMC modules. We came to the conclusion that more often then not, the mmc
chipset might be the problem and not the eMMC module itself. To remedy this the
broken-hpi parameter is now also checked on the chipset level.

On the sunxi platform, all the eMMC users with emmc modules that support HPI
need the broken-hpi flag, indicating that the sunxi mmc controller is likely
not properly supporting HPI. We disable this on the chipset level for these
chipsets.

As for the broken-hpi flag in the devicetree's, those should in theory be
removed from the boards in question in a separate patch when in agreement, as
technically, the eMMC module supports HPI just fine and thus the we are lying
about what really is broken.

This was tested on an OLinuXino Lime2 with 4GB industrial grade Micron eMMC
flash.

Olliver Schinagl (2):
  mmc: core: Improve marking broken HPI through devicetree
  mmc: sunxi: Mark the HPI of the mmc controller broken by default

 drivers/mmc/core/host.c      | 2 ++
 drivers/mmc/core/mmc.c       | 2 +-
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 include/linux/mmc/host.h     | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.8.0.rc3
