From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Oct 2015 00:42:12 +0800
Subject: [PATCH v2 0/2] irqchip: sunxi-nmi: misc. / aesthetic improvements
Message-ID: <1444063334-19832-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of my sunxi-nmi aesthetic improvement series.

sunxi-nmi uses its DT node name, which is normally "interrupt-controller",
as its irqchip name. This only serves to confuse the user when one sees
"interrupt-controller" in /sys/kernel/debug/irq_domain_mapping or
/proc/interrupts. We want it to show something more specific, like
"sunxi-nmi". Also do this for the printk calls.

While at it, also switch to the new of_io_request_and_map() call, so the
IO resource is properly held, and also shows up in /proc/iomem.


Changes since v1:

  - Use the "pr_fmt" macro in patch 1, and also remove __func__ from the
    error message in the interrupt type setter, sunxi_sc_nmi_set_type().

  - Update the commit message of patch 1 to reflect the change above.

  - Add a proper commit message for patch 2.


Regards
ChenYu


Chen-Yu Tsai (2):
  irqchip: sunxi-nmi: Use driver name instead of DT node name for
    identification
  irqchip: sunxi-nmi: switch to of_io_request_and_map() from of_iomap()

 drivers/irqchip/irq-sunxi-nmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.5.3
