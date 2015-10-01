From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  1 Oct 2015 23:33:47 +0800
Subject: [PATCH 0/2] irqchip: sunxi-nmi: misc. / aesthetic improvements
Message-ID: <1443713629-17415-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

sunxi-nmi uses its DT node name, which is normally "interrupt-controller",
as its irqchip name. This only serves to confuse the user when one sees
"interrupt-controller" in /sys/kernel/debug/irq_domain_mapping or
/proc/interrupts. We want it to show something more specific, like
"sunxi-nmi". Also do this for the printk calls.

While at it, also switch to the new of_io_request_and_map() call, so the
IO resource is properly held, and also shows up in /proc/iomem.


Regards
ChenYu


P.S. I'm thinking about removing the "_irq_chip" suffix from the axp20x
irq chip name as well.


Chen-Yu Tsai (2):
  irqchip: sunxi-nmi: Use driver name instead of DT node name for
    identification
  irqchip: sunxi-nmi: switch to of_io_request_and_map() from of_iomap()

 drivers/irqchip/irq-sunxi-nmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.5.3
