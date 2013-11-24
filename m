From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 22:47:32 -0500
Subject: [PATCH 0/2] ARM: mm: Couple of fixes for setup_dma_zone()
Message-ID: <1385264854-30162-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The setup_dma_zone() is broken on machines which needs to do late code
patching. Such machines updates the __pv_phys_offset and hence
setup_dma_zone() needs to called post those updates.

Hopefully series doesn't break anything since the setup_dma_zone()
now gets moved bit further down in the init sequence.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>

Santosh Shilimkar (2):
  ARM: mm: Fix the arm_dma_limit calculation
  ARM: mm: Call setup_dma_zone() post early_paging_init()

 arch/arm/kernel/setup.c |    3 +--
 arch/arm/mm/init.c      |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
1.7.9.5
