From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 26 Oct 2015 19:02:11 +0800
Subject: [RFC PATCH 0/3] PCI: generate proper configuration access cycles
Message-ID: <1445857334-6936-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inspired by Russell King's patch[1], I found some pci hosts also have the
same issue of "reading 32-bits from the command register, modifying the
command register, and then writing it back has the effect of clearing
any status bits that were indicating at that time" as pointed out by
Russell. Fix them by using the pci_generic_config_write.

Another problem is do we need to use proper readb/readw for config read?

Jisheng Zhang (3):
  PCI: iproc: generate proper configuration access cycles
  PCI: tegra: generate proper configuration access cycles
  PCI: xgene: generate proper configuration access cycles

 drivers/pci/host/pci-tegra.c  | 2 +-
 drivers/pci/host/pci-xgene.c  | 2 +-
 drivers/pci/host/pcie-iproc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.6.2
