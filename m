From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 19 Dec 2016 15:16:05 +0100
Subject: [PATCH 0/4] Add support for the ethernet switch on the EXPRESSObin
Message-ID: <20161219141610.30934-1-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds support for the Marvell ethernet switch 88E6341.
It also add the devicetree definition of thid switch to the DT board.

Romain Perier (4):
  net: dsa: mv88e6xxx: Allow mv88e6xxx_smi_init() to be used at address
    0x1
  net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for PHY addr >=
    num_of_ports
  net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341/88E6141
  arm64: dts: marvell: Add ethernet switch definition for the
    EXPRESSObin

 .../boot/dts/marvell/armada-3720-espressobin.dts   | 67 ++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.c                   | 24 ++++----
 drivers/net/dsa/mv88e6xxx/mv88e6xxx.h              |  4 +-
 3 files changed, 84 insertions(+), 11 deletions(-)

-- 
2.9.3
