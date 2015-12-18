From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 15:53:00 +0000
Subject: [PULL] GIC updates for v4.5
Message-ID: <1450453980-26142-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Jason,

This is the pull request for the GIC updates aimed at v4.5. Not a lot
this time (what a relief!), but an interesting series from Linus
Walleij coming out of his work converting the ARM RealView platforms
to DT, and a couple of mundane fixes.

Please pull!

Thanks,

	M.

The following changes since commit 9f9499ae8e6415cefc4fe0a96ad0e27864353c89:

  Linux 4.4-rc5 (2015-12-13 17:42:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gic-4.5

for you to fetch changes up to a27d21e03eb14a63dae12467a7655be3334ac80c:

  irqchip/gic: Kconfig the number of instances (2015-12-18 10:37:00 +0000)

----------------------------------------------------------------
Linus Walleij (4):
      irqchip/gic: Fix ARM11MPCore GIC bindings
      irqchip/gic: Support RealView variant setup
      irqchip/gic: Assign irqchip dynamically
      irqchip/gic: Kconfig the number of instances

Marc Zyngier (2):
      irqchip/gic-v2m: Fix of_node refcount on error
      irqchip/gic: Make interrupt ID 1020 invalid

 .../bindings/interrupt-controller/arm,gic.txt      |  1 +
 drivers/irqchip/Kconfig                            |  5 ++
 drivers/irqchip/Makefile                           |  1 +
 drivers/irqchip/irq-gic-realview.c                 | 43 +++++++++++++++++
 drivers/irqchip/irq-gic-v2m.c                      |  2 +-
 drivers/irqchip/irq-gic.c                          | 56 ++++++++++------------
 include/linux/irqchip/arm-gic.h                    | 10 ++++
 7 files changed, 86 insertions(+), 32 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-realview.c
