From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Jul 2010 23:05:58 -0400 (EDT)
Subject: Git pull request: Orion/Kirkwood/Dove for next merge window
In-Reply-To: <alpine.LFD.2.00.1007061951540.6020@xanadu.home>
References: <alpine.LFD.2.00.1007061951540.6020@xanadu.home>
Message-ID: <alpine.LFD.2.00.1007162300190.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Jul 2010, Nicolas Pitre wrote:

> Russell, please pull
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git
> 
> This contains an assortment of patches for Orion, Kirkwood and Dove 
> support to be merged in the next merge window.  

This was rebased on latest mainline to pick up the mach-types update.

The shortlog and diffstat is as follows:

Arnaud Patard (1):
      [ARM] qnap tsx1x: fix section mismatch

Benjamin Herrenschmidt (3):
      net/phy/marvell: Expose IDs and flags in a .h and add dns323 LEDs setup flag
      [ARM] orion5x: Base support for DNS-323 rev C1
      [ARM] orion5x: Fix soft-reset for some platforms

Benjamin Zores (1):
      [ARM] Kirkwood: update MPP definition.

Dmytro Milinevskyy (1):
      [ARM] Marvell OpenRD-Ultimate machine support

Martin Michlmayr (6):
      [ARM] Kirkwood: Export GPIO indicating jumper setting of JP1
      [ARM] Kirkwood: Fix explanation of MPP45 for QNAP TS41x
      [ARM] orion5x: Set links to solid on D-Link DNS-323
      [ARM] Kirkwood: Add MPP44 (board ID) on TS-219
      [ARM] Kirkwood: Add support for HP t5325 Thin Client
      [ARM] Orion: DNS-323 C1 requires phylib

Nicolas Pitre (3):
      [ARM] Kirkwood: fix HP t5325 after commit 6605742f2a
      [ARM] Kirkwood: more factorization of the PCIe init code
      [ARM] Kirkwood: add missing machine targets to defconfig

Olaf Rempel (1):
      [ARM] orion/kirkwood: reset PCIe unit on boot

Saeed Bishara (6):
      [ARM] Kirkwood: configure NAND mpp's for db88f6281
      [ARM] Kirkwood: add support for rev A1 of the 88f6192 and 88f6180 chips.
      [ARM] Kirkwood: Add support for 88f6282
      [ARM] PCI: add platform private data to pci_sys_data
      [ARM] Kirkwood: add support for PCIe1
      [ARM] Dove: platform device registration for the sdio interfaces

Simon Guinot (3):
      [ARM] Kirkwood: add LaCie Network Space Max v2 support
      leds: add LED driver for Network Space v2 LEDs
      [ARM] Kirkwood: update LED support for Network Space v2

 arch/arm/configs/kirkwood_defconfig               |    8 +
 arch/arm/include/asm/mach/pci.h                   |    1 +
 arch/arm/mach-dove/common.c                       |   61 ++
 arch/arm/mach-dove/common.h                       |    2 +
 arch/arm/mach-dove/dove-db-setup.c                |    2 +
 arch/arm/mach-kirkwood/Kconfig                    |   19 +
 arch/arm/mach-kirkwood/Makefile                   |    2 +
 arch/arm/mach-kirkwood/addr-map.c                 |   10 +-
 arch/arm/mach-kirkwood/common.c                   |   38 +-
 arch/arm/mach-kirkwood/common.h                   |    5 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c       |   18 +-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    3 +-
 arch/arm/mach-kirkwood/include/mach/irqs.h        |    1 +
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    |   39 +-
 arch/arm/mach-kirkwood/include/mach/leds-ns2.h    |   26 +
 arch/arm/mach-kirkwood/mpp.c                      |    3 +-
 arch/arm/mach-kirkwood/mpp.h                      |  596 ++++++++-------
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c    |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c        |  104 ++-
 arch/arm/mach-kirkwood/netxbig_v2-setup.c         |   32 +-
 arch/arm/mach-kirkwood/openrd-setup.c             |   29 +-
 arch/arm/mach-kirkwood/pcie.c                     |  174 +++--
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c          |    2 +-
 arch/arm/mach-kirkwood/t5325-setup.c              |  194 +++++
 arch/arm/mach-kirkwood/ts219-setup.c              |   11 +-
 arch/arm/mach-kirkwood/ts41x-setup.c              |   39 +-
 arch/arm/mach-kirkwood/tsx1x-common.c             |    2 +-
 arch/arm/mach-orion5x/Kconfig                     |    1 +
 arch/arm/mach-orion5x/dns323-setup.c              |  370 ++++++++--
 arch/arm/mach-orion5x/include/mach/system.h       |    2 +
 arch/arm/plat-orion/pcie.c                        |   34 +
 drivers/leds/Kconfig                              |    9 +
 drivers/leds/Makefile                             |    1 +
 drivers/leds/leds-ns2.c                           |  338 ++++++++
 drivers/net/phy/marvell.c                         |   38 +-
 include/linux/marvell_phy.h                       |   20 +
 37 files changed, 1727 insertions(+), 511 deletions(-)
