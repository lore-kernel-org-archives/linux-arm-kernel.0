From: jm@lentin.co.uk (Jamie Lentin)
Date: Tue, 27 Mar 2012 22:54:10 +0100
Subject: [PATCH V3 0/5] Add support for DNS-320 and DNS-325 using devicetree
Message-ID: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks again to Arnd, Jason & Scott. The differences here are fairly minor.
Apart from documentation, I'm guessing that the changes aren't significant
enough to revoke Acked-by, please flame me if I'm wrong!

Changes since v2:
* Split patches further, separating orion_nand and kirkwood changes
* dts renames: "bank-width", not "width". "okay", not "ok"
* Separate documentation out into separate patch, add references to
  partition.txt to all mtd bindings.

Changes since v1:
* Rebase against kirkwood_dt_for_3.4, removing premature devicetree ports.
* Move additions into a separate board-dnskw.c. It could be separated further
  into a board-dns320.c and board-dns325.c but it probably isn't worth it.
* s/marvell,/mrvl,/g
* Include an example dtb partition in documentation
* Copy structure of serial nodes to allow common options for NAND to be set
  in kirkwood.dtsi
* Simplifications in orion-nand.c

Jamie Lentin (5):
  ARM: kirkwood: Basic support for DNS-320 and DNS-325
  mtd: Add orion_nand devicetree bindings
  ARM: kirkwood: Allow nand to be configured via. devicetree
  ARM: kirkwood: Define DNS-320/DNS-325 NAND in fdt
  mtd: Move fdt partition documentation to a seperate file

 .../devicetree/bindings/mtd/arm-versatile.txt      |    4 +-
 .../devicetree/bindings/mtd/atmel-dataflash.txt    |    3 +
 .../devicetree/bindings/mtd/fsl-upm-nand.txt       |    4 +
 .../devicetree/bindings/mtd/gpio-control-nand.txt  |    3 +
 .../devicetree/bindings/mtd/mtd-physmap.txt        |   23 +--
 .../devicetree/bindings/mtd/orion-nand.txt         |   49 ++++
 .../devicetree/bindings/mtd/partition.txt          |   38 +++
 arch/arm/boot/dts/kirkwood-dns320.dts              |   64 +++++
 arch/arm/boot/dts/kirkwood-dns325.dts              |   59 +++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   15 +-
 arch/arm/mach-kirkwood/Kconfig                     |   23 ++
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/Makefile.boot               |    2 +
 arch/arm/mach-kirkwood/board-dnskw.c               |  275 ++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c                  |    5 +
 arch/arm/mach-kirkwood/common.c                    |   12 +
 arch/arm/mach-kirkwood/common.h                    |    6 +
 drivers/mtd/nand/orion_nand.c                      |   35 +++-
 18 files changed, 595 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partition.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dnskw.c

-- 
1.7.9.1
