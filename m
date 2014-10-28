From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 22:41:25 +0100
Subject: [PATCH v2 0/4] pinctrl: sunxi: Add A80 Pin Controller support
Message-ID: <1414532489-23345-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As usual when we support a new SoC, we need to add a new pinctrl
driver.

Here is it, this time for the A80, which doesn't bring anything new
beside one more bank compared to the previous SoCs, but less pins
overall.

Maxime

Changes from v1:
  - Fix a whitespace error in patch 3
  - Added a closing bracket to the module author email
  - Removed the owner field from the driver

Maxime Ripard (4):
  pinctrl: sunxi: Add PN bank base pin
  pinctrl: sunxi: Add A80 pinctrl muxing options
  ARM: sun9i: Enable the A80 pinctrl driver
  ARM: sun9i: optimus: Set UART0 muxing

 arch/arm/boot/dts/sun9i-a80-optimus.dts   |   2 +
 arch/arm/boot/dts/sun9i-a80.dtsi          |  23 +
 drivers/pinctrl/sunxi/Kconfig             |   4 +
 drivers/pinctrl/sunxi/Makefile            |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c | 749 ++++++++++++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h     |   1 +
 6 files changed, 780 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c

-- 
2.1.1
