From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:33 +0200
Subject: [PATCHv2 00/20] Cleanup irqchip_init calls
Message-ID: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a splitted up version of the patch I previously sent to
remove the explicit declaration of irqchip_init as the init_irq callback in
the machine descriptions.

Since it was a pretty tricky patch to merge, since it was touching a lot of
different platforms, I splitted it for each platforms, and rebased it on top
of 3.10-rc1.

The best way to merge it is probably that each one of us take into their tree
the patches that are relevant for our architecture and send them to arm-soc
later on.

Thanks,
Maxime

Changes from v1:
  - Removed the dead include of linux/irqchip.h
  - Splitted the shmobile changes into several patches

Maxime Ripard (20):
  ARM: sunxi: Remove init_irq declaration in machine description
  ARM: zynq: Remove init_irq declaration in machine description
  ARM: nomadik: Remove init_irq declaration in machine description
  ARM: picoxcell: Remove init_irq declaration in machine description
  ARM: shmobile: ape6evm: Remove init_irq declaration in machine
    description
  ARM: shmobile: kzm9g: Remove init_irq declaration in machine
    description
  ARM: shmobile: lager: Remove init_irq declaration in machine
    description
  ARM: shmobile: emev2: Remove init_irq declaration in machine
    description
  ARM: shmobile: r8a73a4: Remove init_irq declaration in machine
    description
  ARM: shmobile: r8a7790: Remove init_irq declaration in machine
    description
  ARM: shmobile: sh73a0: Remove init_irq declaration in machine
    description
  ARM: bcm281xx: Remove init_irq declaration in machine description
  ARM: spear: Remove init_irq declaration in machine description
  ARM: msm: Remove init_irq declaration in machine description
  ARM: mvebu: Remove init_irq declaration in machine description
  ARM: mxs: Remove init_irq declaration in machine description
  ARM: sirf: Remove init_irq declaration in machine description
  ARM: vexpress: Remove init_irq declaration in machine description
  ARM: virt: Remove init_irq declaration in machine description
  ARM: vt8500: Remove init_irq declaration in machine description

 arch/arm/mach-bcm/board_bcm.c                  | 2 --
 arch/arm/mach-msm/board-dt-8660.c              | 2 --
 arch/arm/mach-msm/board-dt-8960.c              | 2 --
 arch/arm/mach-mvebu/armada-370-xp.c            | 2 --
 arch/arm/mach-mxs/mach-mxs.c                   | 2 --
 arch/arm/mach-nomadik/cpu-8815.c               | 2 --
 arch/arm/mach-picoxcell/common.c               | 2 --
 arch/arm/mach-prima2/common.c                  | 4 ----
 arch/arm/mach-shmobile/board-ape6evm.c         | 2 --
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 2 --
 arch/arm/mach-shmobile/board-lager.c           | 2 --
 arch/arm/mach-shmobile/setup-emev2.c           | 2 --
 arch/arm/mach-shmobile/setup-r8a73a4.c         | 2 --
 arch/arm/mach-shmobile/setup-r8a7790.c         | 2 --
 arch/arm/mach-shmobile/setup-sh73a0.c          | 2 --
 arch/arm/mach-spear/spear1310.c                | 2 --
 arch/arm/mach-spear/spear1340.c                | 2 --
 arch/arm/mach-spear/spear300.c                 | 2 --
 arch/arm/mach-spear/spear310.c                 | 2 --
 arch/arm/mach-spear/spear320.c                 | 2 --
 arch/arm/mach-spear/spear6xx.c                 | 2 --
 arch/arm/mach-sunxi/sunxi.c                    | 2 --
 arch/arm/mach-vexpress/v2m.c                   | 2 --
 arch/arm/mach-virt/virt.c                      | 2 --
 arch/arm/mach-vt8500/vt8500.c                  | 2 --
 arch/arm/mach-zynq/common.c                    | 2 --
 26 files changed, 54 deletions(-)

-- 
1.8.1.2
