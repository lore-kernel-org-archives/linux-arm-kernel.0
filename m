From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Dec 2016 16:01:35 -0800
Subject: [PATCH 0/2] ARM: orion5x: Move micon code to a MFD driver
Message-ID: <20161229000137.5553-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series removes some duplicate code between the Kurobox and the
Terastation Pro 2 since they both use the same on-board microcontroller (micon)
attached to their UART1 for system restart.

Future patches will add support for the LEDs, temperature, FAN that the micro
controller provides.

Florian Fainelli (2):
  mfd: micon: Add Buffalo Kurobox Pro, Terastation II Pro/Live driver
  ARM: orion5x: Utilize micon MFD driver

 arch/arm/mach-orion5x/Kconfig                  |   4 +
 arch/arm/mach-orion5x/kurobox_pro-setup.c      | 149 +++---------------
 arch/arm/mach-orion5x/terastation_pro2-setup.c | 149 +++---------------
 drivers/mfd/Kconfig                            |   8 +
 drivers/mfd/Makefile                           |   2 +
 drivers/mfd/micon.c                            | 204 +++++++++++++++++++++++++
 include/linux/platform_data/micon.h            |  10 ++
 7 files changed, 264 insertions(+), 262 deletions(-)
 create mode 100644 drivers/mfd/micon.c
 create mode 100644 include/linux/platform_data/micon.h

-- 
2.9.3
