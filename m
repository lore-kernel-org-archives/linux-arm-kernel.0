From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 4 Nov 2015 12:15:58 -0800
Subject: [PATCH v2 0/2] Power management callbacks for irqchips
Message-ID: <1446668160-17522-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

we recently discussed how to handle power management with GPIO devices
that can generate interrupts here: https://lkml.org/lkml/2015/10/23/305.
At the end of that discussion stood Lars' suggestion to add a new pair of
callbacks to the irqchip for this purpose. This is a first, naive
implementation of that approach.

        Thanks,
        S?ren

v2:
 - add mailing lists (sorry for forgetting that in v1)

S?ren Brinkmann (2):
  genirq: Add irq_pm_(get|put) callbacks to the irqchip
  gpio: zynq: Implement irq_pm_(get|put)

 drivers/gpio/gpio-zynq.c | 20 ++++++++++++++++++++
 include/linux/irq.h      |  4 ++++
 kernel/irq/internals.h   | 14 ++++++++++++++
 kernel/irq/manage.c      | 20 ++++++++++++++++----
 4 files changed, 54 insertions(+), 4 deletions(-)

-- 
2.6.2.3.ga463a5b
