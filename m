From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Jan 2017 20:29:32 +0100
Subject: [PATCH net-next v7 0/3] Add support for the ethernet switch on the
 ESPRESSObin
Message-ID: <cover.69cbc1ba8937d0fc442538f992d62fc88aa26dcc.1485804488.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches adds support for the Marvell Ethernet Topaz switch
family (88E6141/88E6341) which is found on the ESPRESSObin. With this
series the network is usable on this board.

As usual, I rebased the series on the very last net-next/master. In
this series there is no temperature support which need some patches
form Andrew Lunn.

As soon as Andrew Lunn will post the needed patch I will send a patch
to enable the temperature support.

Thanks,

Gregory

Changelog:

v6 -> v7:
- rebased on net-next/master (5b8784aaf29b)
- Fixed the wrong age time coeff from 15s to 3.75s.
- Remove support for temperature sensor

v5 -> v6:
- rebased on net-next/master (d140199af510)
- Fix the redundant check on mv88e6xxx_6341_family (reported by Julia
  Lawall)
- Add support for the 88E6141
- Move support for temperature sensor in the phy part

Gregory CLEMENT (2):
  net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341
  net: dsa: mv88e6xxx: Add support for ethernet switch 88E6141

Romain Perier (1):
  net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for PHY addr >= num_of_ports

 drivers/net/dsa/mv88e6xxx/chip.c      | 102 ++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/mv88e6xxx.h |  21 +++++-
 2 files changed, 113 insertions(+), 10 deletions(-)

base-commit: 334c367fd5cea7a9493c3026f7e6195ebab3d7b9
-- 
git-series 0.9.1
