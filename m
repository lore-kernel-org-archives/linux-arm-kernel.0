From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 22 Feb 2012 19:18:43 +0000
Subject: [PATCH 0/3 v4] arm: kirkwood: add dreamplug/devicetree support
In-Reply-To: <cover.1312906908.git.jason@lakedaemon.net>
References: <cover.1312906908.git.jason@lakedaemon.net>
Message-ID: <cover.1329936660.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides initial support for devicetree on kirkwood for the
dreamplug platform.  After discussing the approach with Arnd Bergman last week
at ELC, we decided to take an incremental approach to the conversion.  First, I
would detect that we were on the dreamplug via the devicetree blob.  Then,
configure uart0 via devicetree.  We chose the uart since it is already well
supported under devicetree.

This patch series has been boot-tested on the dreamplug.

In a future patch series, I plan to migrate spi/flash/partitions over to
devicetree.

When the migration is complete, board-dt.c will not be specific to the
dreamplug, and dts files can be written for all of the other kirkwood boards.

Jason Cooper (3):
  arm: ignore devicetree blobs.
  arm: kirkwood: add dreamplug (fdt) support.
  arm: kirkwood: convert uart0 to devicetree.

 arch/arm/boot/.gitignore                 |    1 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   19 +++
 arch/arm/boot/dts/kirkwood.dtsi          |   14 +++
 arch/arm/mach-kirkwood/Kconfig           |   14 +++
 arch/arm/mach-kirkwood/Makefile          |    1 +
 arch/arm/mach-kirkwood/Makefile.boot     |    2 +
 arch/arm/mach-kirkwood/board-dt.c        |  180 ++++++++++++++++++++++++++++++
 7 files changed, 231 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
 create mode 100644 arch/arm/boot/dts/kirkwood.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-dt.c

-- 
1.7.3.4
