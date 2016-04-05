From: david@lechnology.com (David Lechner)
Date: Tue,  5 Apr 2016 12:31:48 -0500
Subject: [PATCH v4 0/3] davinci_mmc fixes
Message-ID: <1459877512-25479-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a compiler warning in the "fix unwinding in probe" patch where ret
was used uninitalized.

David Lechner (3):
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  ARM: davinci: remove mmc dma resources

 arch/arm/mach-davinci/devices-da8xx.c |  20 -------
 arch/arm/mach-davinci/devices.c       |  16 ------
 drivers/mmc/host/davinci_mmc.c        | 100 ++++++++++++++--------------------
 3 files changed, 40 insertions(+), 96 deletions(-)

-- 
1.9.1
