From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:25:19 +0200
Subject: [PATCH 0/5] Enable mvebu pinctrl/gpio for Dove and Kirkwood
Message-ID: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first step in converting Dove and Kirkwood boards to use
pinctrl. Allow the MVEBU pinctrl driver and GPIO driver to be used by
these two SoC families.

Andrew Lunn (2):
  ARM: Kirkwood: Allow use of pinctrl
  ARM: Kirkwood: Allow use of MVEBU GPIO driver.

Sebastian Hesselbarth (3):
  pinctrl: dove: fix iomem and pdma clock
  ARM: Dove: Make use of pinctrl driver
  ARM: Dove: Make use of MVEBU GPIO driver

 arch/arm/Kconfig                |    6 ++++++
 arch/arm/boot/dts/dove.dtsi     |   19 ++++++++++++++++---
 arch/arm/boot/dts/kirkwood.dtsi |   11 +++++++++--
 arch/arm/plat-orion/irq.c       |    5 +----
 drivers/gpio/Kconfig            |    2 +-
 drivers/pinctrl/Kconfig         |    2 +-
 drivers/pinctrl/pinctrl-dove.c  |   20 +++++++++++++-------
 7 files changed, 47 insertions(+), 18 deletions(-)

-- 
1.7.10.4
