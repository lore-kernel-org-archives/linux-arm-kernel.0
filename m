From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 22:45:30 -0500
Subject: [PATCH v3 0/5] davinci_mmc fixes
Message-ID: <1458186341-6970-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have replaced one of my patches with the patch from Peter Ujfalusi and fixed
a mistake in the "fix unwinding..." patch.

Tested working on LEGO MINDSTORMS EV3 (da850-ish).

David Lechner (4):
  mmc: davinci: remove matching string
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  ARM: davinci: remove mmc dma resources

Peter Ujfalusi (1):
  mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel

 arch/arm/mach-davinci/devices-da8xx.c |  20 -----
 arch/arm/mach-davinci/devices.c       |  16 ----
 drivers/mmc/host/davinci_mmc.c        | 147 ++++++++++++----------------------
 3 files changed, 50 insertions(+), 133 deletions(-)

-- 
1.9.1
