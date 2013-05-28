From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 16:28:28 -0400
Subject: [GIT PULL 4/5] ARM: mvebu: pcie bridge enhancements for v3.11
In-Reply-To: <20130528202433.GH31290@titan.lakedaemon.net>
References: <20130528202140.GG31290@titan.lakedaemon.net>
 <20130528202433.GH31290@titan.lakedaemon.net>
Message-ID: <20130528202828.GJ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 3d9939c92efdd4ced672b94994959ca71b141cb8:

  pci: mvebu: fix return value check in mvebu_pcie_probe() (2013-05-27 15:51:56 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/pcie_bridge-3.11

for you to fetch changes up to 6eb237c41acc1cf00b3b1176ad4a0ed3f221d630:

  pci: mvebu: fix the emulation of the status register (2013-05-27 16:01:15 +0000)

----------------------------------------------------------------
mvebu pcie driver (bridge) for v3.11

 - mvebu
    - allow enumeration of devices beyond physical bridges
    - remove faking the slot location
    - fix status register emulation

depends
 - mvebu/pcie
    -mvebu/of_pci

----------------------------------------------------------------
Thomas Petazzoni (3):
      pci: mvebu: no longer fake the slot location of downstream devices
      pci: mvebu: allow the enumeration of devices beyond physical bridges
      pci: mvebu: fix the emulation of the status register

 drivers/pci/host/pci-mvebu.c | 55 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 11 deletions(-)
