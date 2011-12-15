From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 15:25:16 +0100
Subject: [GIT PULL] at91: devices and boards files update for 3.3
Message-ID: <4EEA034C.9020800@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This pull request adds the ISI to the sam9m10g45 board. As ISI has 
been waited for a long time on AT91, I think it is not possible to wait
for the DT support. Moreover, DT support for this camera sensor + ISI 
soc interface seems not so trivial and will certainly need a handful of 
kernel releases before being stabilized.
Other changes are quite simple and self-explanatory...

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd-3.3-device_board

Hong Xu (1):
      ARM: at91: Update struct atmel_nand_data to support PMECC

Josh Wu (2):
      ARM: at91: add clock selection parameter for at91_add_device_isi()
      ARM: at91: add Atmel ISI and ov2640 support on sam9m10g45 board

Nicolas Ferre (2):
      ARM: at91/dma: remove platform data from DMA controller
      ARM: at91/dma: DMA controller registering with DT support

 arch/arm/mach-at91/at91sam9263_devices.c |   13 +++-
 arch/arm/mach-at91/at91sam9g45_devices.c |  113 +++++++++++++++++++++++++++---
 arch/arm/mach-at91/at91sam9rl_devices.c  |    8 +--
 arch/arm/mach-at91/board-sam9m10g45ek.c  |   80 ++++++++++++++++++++-
 arch/arm/mach-at91/include/mach/board.h  |    6 ++-
 5 files changed, 198 insertions(+), 22 deletions(-)

Thanks, best regards,
-- 
Nicolas Ferre
