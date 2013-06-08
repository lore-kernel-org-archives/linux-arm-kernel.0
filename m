From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  8 Jun 2013 12:05:42 +0200
Subject: [PATCH 0/4] Add external interrupt support for Allwinner SoCs
Message-ID: <1370685946-3718-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch adds the support for the external interrupt sources found in
the PIO IP of the Allwinner SoCs.

This IP handles up to 32 external interrupt source, that are exposed
through a particular pin function on some pins handled by the PIO.

We thus need to change the muxing to enable these interrupts, which
leads to some additional logic.

Thanks,
Maxime

Maxime Ripard (4):
  pinctrl: sunxi: Search the description array by pin id
  pinctrl: sunxi: Add external interrupts support
  pinctrl: sunxi: Add external interrupt functions
  ARM: sunxi: dt: Register the pio node as interrupt controller

 arch/arm/boot/dts/sun4i-a10.dtsi |   2 +
 arch/arm/boot/dts/sun5i-a13.dtsi |   2 +
 drivers/pinctrl/pinctrl-sunxi.c  | 307 +++++++++++++++++++++++++++++++++------
 drivers/pinctrl/pinctrl-sunxi.h  |  68 +++++++++
 4 files changed, 331 insertions(+), 48 deletions(-)

-- 
1.8.3
