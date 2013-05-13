From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 May 2013 11:43:59 +0200
Subject: [PATCH 00/14] Cleanup irqchip_init calls
Message-ID: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a splitted up version of the patch I previously sent to
remove the explicit declaration of irqchip_init as the init_irq callback in
the machine descriptions.

Since it was a pretty tricky patch to merge, since it was touching a lot of
different platforms, I splitted it for each platforms, and rebased it on top
of 3.10-rc1.

Thanks,
Maxime

Maxime Ripard (14):
  ARM: sunxi: Remove init_irq declaration in machine description
  ARM: zynq: Remove init_irq declaration in machine description
  ARM: nomadik: Remove init_irq declaration in machine description
  ARM: picoxcell: Remove init_irq declaration in machine description
  ARM: shmobile: Remove init_irq declaration in machine description
  ARM: bcm281xx: Remove init_irq declaration in machine description
  ARM: spear: Remove init_irq declaration in machine description
  ARM: msm: Remove init_irq declaration in machine description
  ARM: mvebu: Remove init_irq declaration in machine description
  ARM: mxs: Remove init_irq declaration in machine description
  ARM: sirf: Remove init_irq declaration in machine description
  ARM: vexpress: Remove init_irq declaration in machine description
  ARM: virt: Remove init_irq declaration in machine description
  ARM: vt8500: Remove init_irq declaration in machine description

 arch/arm/mach-bcm/board_bcm.c                  | 1 -
 arch/arm/mach-msm/board-dt-8660.c              | 1 -
 arch/arm/mach-msm/board-dt-8960.c              | 1 -
 arch/arm/mach-mvebu/armada-370-xp.c            | 1 -
 arch/arm/mach-mxs/mach-mxs.c                   | 1 -
 arch/arm/mach-nomadik/cpu-8815.c               | 1 -
 arch/arm/mach-picoxcell/common.c               | 1 -
 arch/arm/mach-prima2/common.c                  | 3 ---
 arch/arm/mach-shmobile/board-ape6evm.c         | 1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 -
 arch/arm/mach-shmobile/board-lager.c           | 1 -
 arch/arm/mach-shmobile/setup-emev2.c           | 1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c         | 1 -
 arch/arm/mach-shmobile/setup-r8a7790.c         | 1 -
 arch/arm/mach-shmobile/setup-sh73a0.c          | 1 -
 arch/arm/mach-spear/spear1310.c                | 1 -
 arch/arm/mach-spear/spear1340.c                | 1 -
 arch/arm/mach-spear/spear300.c                 | 1 -
 arch/arm/mach-spear/spear310.c                 | 1 -
 arch/arm/mach-spear/spear320.c                 | 1 -
 arch/arm/mach-spear/spear6xx.c                 | 1 -
 arch/arm/mach-sunxi/sunxi.c                    | 1 -
 arch/arm/mach-vexpress/v2m.c                   | 1 -
 arch/arm/mach-virt/virt.c                      | 1 -
 arch/arm/mach-vt8500/vt8500.c                  | 1 -
 arch/arm/mach-zynq/common.c                    | 1 -
 26 files changed, 28 deletions(-)

-- 
1.8.1.2
