From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue,  1 Nov 2011 19:32:31 +0100
Subject: [PATCH 0/3] Initial PXA DT bindings
Message-ID: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset starts effort to convert PXA machines to DT. I started with PXA
UART driver and added a stub machine, which I plan to eventually rename to
board-pxa-dt when ready.

The file in patch 0002 contains style errors (line over 80), because they are 1
character over. To avoid crippling readability, I left that as is.

Marek Vasut (3):
  ARM: pxa: Add DT support to pxa2xx-uart
  ARM: pxa: Add DT testing machine
  ARM: pxa: Add basic DTS files for PXA/Vpac270 testing machine

 arch/arm/boot/dts/pxa-vpac270.dts |   37 +++++++++++++++++
 arch/arm/boot/dts/pxa.dtsi        |   72 ++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/Kconfig         |   15 +++++++
 arch/arm/mach-pxa/Makefile        |    3 +
 arch/arm/mach-pxa/vpac270-dt.c    |   82 +++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/pxa.c          |   50 +++++++++++++++++++++-
 6 files changed, 256 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa-vpac270.dts
 create mode 100644 arch/arm/boot/dts/pxa.dtsi
 create mode 100644 arch/arm/mach-pxa/vpac270-dt.c

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>

-- 
1.7.6.3
