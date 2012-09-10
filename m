From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Sep 2012 01:48:35 -0400
Subject: [GIT PULL V2 1/4] ARM: Kirkwood: DT bindings for v3.7
In-Reply-To: <20120829001129.GO19437@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
Message-ID: <20120910054835.GC15277@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This branch depends on arm/cache-l2x0 which is going in through rmk's
tree.  arm/cache-l2x0 contains the following from Gregory Clement:

	arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
	arm: cache-l2x0: add an optional register to save/restore

When I created kirkwood/dt, I merged arm/cache-l2x0.  So, you shouldn't
get a conflict when you pull both of these, right?  Or, should I do the
request-pull based on arm/cache-l2x0?  That doesn't sound right.  Just
let me know if I need to fix it.

thx,

Jason.

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/dt

Andrew Lunn (3):
      ARM: Kirkwood: ehci-orion: Add device tree binding
      ARM: Kirkwood: Convert all DT boards to EHCI via DT.
      Crypto: CESA: Add support for DT based instantiation.

Arnaud Patard (2):
      ARM: Kirkwood: Describe iconnect keys in DT.
      ARM: Kirkwood: Describe iconnect nand in DT.

Gregory CLEMENT (6):
      arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
      arm: cache-l2x0: add an optional register to save/restore
      arm: cache-l2x0: add support for Aurora L2 cache ctrl
      arm: mvebu: add L2 cache support
      arm: mvebu: add Aurora L2 Cache Controller to the DT
      arm: l2x0: add aurora related properties to OF binding

 Documentation/devicetree/bindings/arm/l2cc.txt     |    9 +
 .../devicetree/bindings/crypto/mv_cesa.txt         |   20 ++
 .../devicetree/bindings/usb/ehci-orion.txt         |   19 ++
 arch/arm/boot/dts/armada-370.dtsi                  |    6 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    7 +
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   50 ++++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   20 ++-
 arch/arm/include/asm/hardware/cache-aurora-l2.h    |   55 ++++
 arch/arm/include/asm/hardware/cache-l2x0.h         |    5 +
 arch/arm/mach-kirkwood/board-dnskw.c               |    1 -
 arch/arm/mach-kirkwood/board-dreamplug.c           |    1 -
 arch/arm/mach-kirkwood/board-dt.c                  |    3 +-
 arch/arm/mach-kirkwood/board-goflexnet.c           |    1 -
 arch/arm/mach-kirkwood/board-ib62x0.c              |    1 -
 arch/arm/mach-kirkwood/board-iconnect.c            |   49 ----
 arch/arm/mach-kirkwood/board-lsxl.c                |    1 -
 arch/arm/mach-kirkwood/board-ts219.c               |    1 -
 arch/arm/mach-mvebu/Kconfig                        |    1 +
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |    4 +
 arch/arm/mm/cache-l2x0.c                           |  275 ++++++++++++++++++--
 drivers/crypto/mv_cesa.c                           |   17 +-
 drivers/usb/host/ehci-orion.c                      |   61 ++++-
 22 files changed, 522 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt
 create mode 100644 arch/arm/include/asm/hardware/cache-aurora-l2.h
