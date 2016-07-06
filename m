From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jul 2016 18:59:40 +0800
Subject: [PATCH 0/2] PCI: designware: let dw_pcie_link_up() beware of LTSSM
 training bit
Message-ID: <1467802782-3024-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch1 is a trivial clean up: move the parameters for wait for link
into the core pcie-designware.c

Since link may be UP but still in link training, if so, we can't think
the link is up and operating correctly. So patch2 teaches
dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.


Jisheng Zhang (2):
  PCI: designware: mv parameters for wait for link into
    pcie-designware.c
  PCI: designware: let dw_pcie_link_up() beware of LTSSM training bit

 drivers/pci/host/pcie-designware.c | 11 +++++++++--
 drivers/pci/host/pcie-designware.h |  5 -----
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.8.1
