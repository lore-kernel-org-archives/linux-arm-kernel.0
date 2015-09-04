From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 04 Sep 2015 16:29:50 +0300
Subject: [PATCH v4 TRIVIAL 0/2] ARM: Enable GICv2m on 32-bit virt machine
Message-ID: <cover.1441373056.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

qemu implementation of "virt" includes GICv2m. This series allows to use
it also on ARM32 architecture.

v3 => v4:
- Split into two patches as requested by Marc Zyngier
- Use specialized word extraction macros instead of #ifdef

v1 => v2:
Added verbose explanation in commit message

v2 => v3:
Fixed build warning in irq-gic-v2m.c

v1 => v2:
Added verbose explanation in commit message

Pavel Fedin (2):
  ARM: Enable GICv2m on 32-bit virt machine
  ARM: Fix GICv2m build warning on 32 bits

 arch/arm/Kconfig              | 1 +
 arch/arm/include/asm/Kbuild   | 1 +
 drivers/irqchip/irq-gic-v2m.c | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.4.4
