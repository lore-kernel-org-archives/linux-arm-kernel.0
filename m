From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 Feb 2013 12:10:10 +0100
Subject: [PATCHv2 0/3] 	Add support for user LED on the A13-Olinuxino
Message-ID: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds the user LED of the Olinuxino to the device tree.

To do so, we also add a custom of_xlate function to the PIO driver so that
we can use a more convenient format for the gpios from the device tree.

Linus, since you took the dt changes for the pinctrl driver in your tree, maybe you could merge the two first patches, the second patch depending on patches in
your tree.

Thanks,
Maxime

Changes:
  - Rebased on top of linus walleij allwinner-pinctrl branch

Maxime Ripard (3):
  pinctrl: sunxi: Add of_xlate function
  sunxi: dts: Report the pinctrl nodes as gpio-controllers
  sunxi: a13-olinuxino: Add user LED to the device tree

 arch/arm/boot/dts/sun4i-a10.dtsi          |    4 +++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts |   20 ++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi          |    4 +++-
 drivers/pinctrl/pinctrl-sunxi.c           |   20 ++++++++++++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)

-- 
1.7.10.4
