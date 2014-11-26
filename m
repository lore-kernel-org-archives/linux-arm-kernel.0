From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 26 Nov 2014 15:13:59 -0600
Subject: [RFC PATCH 0/2] Add ioremap_exec enhancements
Message-ID: <cover.1417029918.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some platforms need the ability to ioremap memory for use with small
chunks of code, like in certain PM applications that run from sram.

This series provides a common way to call an arch's ioremap_exec, which
currently only exists for ARM, so that we can use it in the generic
sram driver in a forthcoming patch.

This patch is part of a patch series split into several smaller sets
for introducing suspend on AM335x. I plan to use it to copy several
pieces of ASM code from an EMIF driver and the SoC PM code to run from
SRAM on the SoC. I have pushed a branch here [1] based on v3.18-rc6
with all required patches so that the higher level plan for these
patches can be seen.

Regards,
Dave

[1] https://github.com/dgerlach/linux-pm/tree/rfc-pm-am335x-v3.18-rc6

Russ Dill (2):
  asm-generic: io: Add exec versions of ioremap
  lib: devres: Add exec versions of devm_ioremap_resource and friends

 arch/arm/include/asm/io.h   |   2 +
 include/asm-generic/iomap.h |   5 ++
 include/linux/device.h      |  19 ++++++-
 include/linux/io.h          |   9 +++-
 lib/devres.c                | 125 ++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 154 insertions(+), 6 deletions(-)

-- 
2.1.0
