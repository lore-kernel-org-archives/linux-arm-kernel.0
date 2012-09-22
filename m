From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 13:24:22 -0400
Subject: [GIT PULL V5 3/7] ARM: kirkwood dt changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120922172422.GH5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
  - Based on v3.6-rc5

New bindings:
  - iconnect nand and keys
  - mv_cesa
  - gpio-fan

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/dt

Andrew Lunn (1):
      Crypto: CESA: Add support for DT based instantiation.

Arnaud Patard (2):
      ARM: Kirkwood: Describe iconnect keys in DT.
      ARM: Kirkwood: Describe iconnect nand in DT.

Jamie Lentin (2):
      hwmon: Add devicetree bindings to gpio-fan
      ARM: kirkwood: Use devicetree to define DNS-32[05] fan

 .../devicetree/bindings/crypto/mv_cesa.txt         |   20 ++++
 .../devicetree/bindings/gpio/gpio-fan.txt          |   25 ++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   10 ++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   50 ++++++++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   12 ++-
 arch/arm/mach-kirkwood/board-dnskw.c               |   26 ----
 arch/arm/mach-kirkwood/board-dt.c                  |    2 +-
 arch/arm/mach-kirkwood/board-iconnect.c            |   48 --------
 drivers/crypto/mv_cesa.c                           |   17 +++-
 drivers/hwmon/gpio-fan.c                           |  120 ++++++++++++++++++++
 10 files changed, 251 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt
