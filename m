From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon, 19 Dec 2016 22:28:52 +0100
Subject: [PATCH 0/2] Patches to make i.MX31 PDK board boot again
Message-ID: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been working on getting the current kernel (v4.9) as well as the stable
kernels to boot on the i.MX31 PDK board. The following is my summary of 
which patches/changes are required for each kernel series. Some patches
have been posted on the mailing lists, one is in the v4.9 kernel and then
there are two new patches in this series.

On all kernels the standard imx_v6_v7_defconfig was used.

The patches in this series applies on v4.9 as well as the imx-soc/for-next
tree as of today.

Kernel 4.9:
[RESERVE-PATCH] [IMX-WDT-PATCH] [IPU-IRQ-PATCH] [MC13xxx-PATCH]

Kernel 4.8.x:
[RESERVE-PATCH] [IMX-WDT-PATCH] [IPU-IRQ-PATCH] [MC13xxx-PATCH] 
[IMX-SPI-PATCH]

Kernel 4.4.x:
[RESERVE-PATCH] [IMX-WDT-PATCH] [IPU-IRQ-PATCH] [MC13xxx-PATCH]

Kernel 4.1.x:
[RESERVE-PATCH] [IMX-WDT-PATCH] [IPU-IRQ-PATCH] [MC13xxx-PATCH]

Kernel 3.18.x:
[RESERVE-PATCH] [MC13xxx-PATCH]

Kernel 3.16.x:
[RESERVE-PATCH]

Kernel 3.14.x, 3.12.x, 3.10..x, 3.4.x, 3.2.x:
No changes needed.

[RESERVE-PATCH] https://marc.info/?l=linux-arm-kernel&m=148168166012794&w=2
[IMX-WDT-PATCH] https://marc.info/?l=linux-arm-kernel&m=148141853206440&w=2
[IPU-IRQ-PATCH] Patch 1 in my series
[MC13xxx-PATCH] Patch 2 in my series
[IMX-SPI-PATCH] Commit 2636ba8fa39915c7b8d73166961ebbb4c14251cd

Regards, Magnus

Magnus Lilja (2):
  i.MX31: ipu: Make sure the interrupt routine checks all interrupts.
  mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.

 drivers/dma/ipu/ipu_irq.c  | 2 +-
 drivers/mfd/mc13xxx-core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4
