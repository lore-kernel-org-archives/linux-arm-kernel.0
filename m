From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  7 Nov 2011 22:31:42 +0100
Subject: [PATCH 0/3 V2] Initial PXA DT bindings
In-Reply-To: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
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
 arch/arm/boot/dts/pxa.dtsi        |   71 ++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/Kconfig         |   15 +++++++
 arch/arm/mach-pxa/Makefile        |    3 +
 arch/arm/mach-pxa/vpac270-dt.c    |   82 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/vpac270.c       |    2 +
 drivers/tty/serial/pxa.c          |   46 +++++++++++++++++++-
 7 files changed, 253 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa-vpac270.dts
 create mode 100644 arch/arm/boot/dts/pxa.dtsi
 create mode 100644 arch/arm/mach-pxa/vpac270-dt.c

V2: Adjust to recent DT changes (see patches for details)

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <robherring2@gmail.com>

-- 
1.7.7.1
