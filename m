From: carlo@caione.org (Carlo Caione)
Date: Sat,  8 Feb 2014 17:05:52 +0100
Subject: [PATCH 0/2] input: misc: Add support for axp20x Power Enable Key
Message-ID: <1391875554-6383-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set adds support for the button used by PMICs axp202 and axp209.
The button is used to power on/off the SoC connected to PMIC but also it can
automatically identify long/short press.

PEK is intended as subsystem for the MFD driver so it depends on the axp20x
header files.

Bindings documentation has been already included with documentation for the MFD.

Carlo Caione (2):
  input: misc: Add driver for axp20x power enable key
  input: misc: dts: Add axp20x-pek node to axp20x.dtsi

 arch/arm/boot/dts/axp20x.dtsi   |   6 +
 drivers/input/misc/Kconfig      |  11 ++
 drivers/input/misc/Makefile     |   1 +
 drivers/input/misc/axp20x-pek.c | 278 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 296 insertions(+)
 create mode 100644 drivers/input/misc/axp20x-pek.c

-- 
1.8.5.3
