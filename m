From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 15:01:03 +0900
Subject: [PATCH 00/04] ARM: shmobile: Use default ->init_irq()
Message-ID: <20130701060103.21728.83833.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Use default ->init_irq()

[PATCH 01/04] ARM: shmobile: Use default ->init_irq() on EMEV2
[PATCH 02/04] ARM: shmobile: Use default ->init_irq() on r8a73a4
[PATCH 03/04] ARM: shmobile: Use default ->init_irq() on r8a7790
[PATCH 04/04] ARM: shmobile: Use default ->init_irq() on sh73a0

Rework the mach-shmobile code to provide NULL as ->init_irq() callback
instead of irqchip_init(). This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130701 and
 [PATCH v2 00/07] ARM: shmobile: Remove unused auxdata and callbacks

 arch/arm/mach-shmobile/board-ape6evm.c         |    2 --
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 --
 arch/arm/mach-shmobile/board-lager.c           |    2 --
 arch/arm/mach-shmobile/setup-emev2.c           |    2 --
 arch/arm/mach-shmobile/setup-r8a73a4.c         |    2 --
 arch/arm/mach-shmobile/setup-r8a7790.c         |    2 --
 arch/arm/mach-shmobile/setup-sh73a0.c          |    2 --
 7 files changed, 14 deletions(-)
