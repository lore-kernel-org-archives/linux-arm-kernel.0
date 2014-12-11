From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 11 Dec 2014 14:23:04 +0000
Subject: [PATCH 0/4] GICv3: add 32bit compatibility
Message-ID: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds 32bit compatibility to Marc's GICv3 driver. Only SGIs,
PPIs and SPIs support is present. No ITS nor virtualisation.

It is based on 3.18.

Jean-Philippe Brucker (4):
  arm64: GICv3: refactor the AArch64 specific parts
  arm64: GICv3: change unsigned types for AArch32 compatibility
  arm64: GICv3: Specialize readq and writeq accesses
  ARM: add 32bit support to GICv3

 arch/arm/include/asm/arch_gicv3.h   | 182 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 141 ++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c        |  69 ++++----------
 include/linux/irqchip/arm-gic-v3.h  |  95 +++----------------
 4 files changed, 356 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/include/asm/arch_gicv3.h
 create mode 100644 arch/arm64/include/asm/arch_gicv3.h

-- 
2.2.0.rc1
