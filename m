From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Mar 2013 21:46:43 +0100
Subject: [PATCHv2 0/2] ARM: Remove boilerplate irqchip_init code
Message-ID: <1364503606-10597-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The introduction of the irqchip architecture has made possible to define
a central common function, irqchip_init, as our .init_irq callback in the
machine_desc structure.

We actually see more and more sub-architectures using only the irqchip_init
as their init_irq function, so in order to remove some boilerplate code,
this patchset makes the ARM core to call irqchip_init if no function has
been specified in the init_irq machine_desc field.

This has been tested on the sunxi platform, on top of the cleanup patches,and
it is based on the current arm-soc/for-next branch.

Changes from v1:
  - Call irqchip_init only if CONFIG_OF is defined

Maxime Ripard (2):
  ARM: irq: Call irqchit_init if no init_irq function is specified
  ARM: remove mach .init_irq for irqchip_init users

 arch/arm/kernel/irq.c                          |    6 +++++-
 arch/arm/mach-bcm/board_bcm.c                  |    1 -
 arch/arm/mach-msm/board-dt-8660.c              |    1 -
 arch/arm/mach-msm/board-dt-8960.c              |    1 -
 arch/arm/mach-nomadik/cpu-8815.c               |    1 -
 arch/arm/mach-picoxcell/common.c               |    1 -
 arch/arm/mach-prima2/common.c                  |    1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 -
 arch/arm/mach-shmobile/setup-emev2.c           |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c          |    1 -
 arch/arm/mach-spear/spear1310.c                |    1 -
 arch/arm/mach-spear/spear1340.c                |    1 -
 arch/arm/mach-spear/spear300.c                 |    1 -
 arch/arm/mach-spear/spear310.c                 |    1 -
 arch/arm/mach-spear/spear320.c                 |    1 -
 arch/arm/mach-spear/spear6xx.c                 |    1 -
 arch/arm/mach-vexpress/v2m.c                   |    1 -
 arch/arm/mach-virt/virt.c                      |    1 -
 arch/arm/mach-zynq/common.c                    |    1 -
 19 files changed, 5 insertions(+), 19 deletions(-)

-- 
1.7.10.4
