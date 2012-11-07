From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Wed,  7 Nov 2012 17:13:10 +0100
Subject: [RFC PATCH 0/2] Kirkwood 98dx4122 pinctrl variant
In-Reply-To: <20121028165711.GG15824@lunn.ch>
References: <20121028165711.GG15824@lunn.ch>
Message-ID: <1352304792-22443-1-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add a pinctrl variant for the kirkwood embedded in the
98dx4122 SoC. Although it is based on a 6281 kirkwood, a lot of pins and
functionalities are absent ant that's why a new variant is needed.

These two patches are based on Andrew's v2 pinctrl branch:

git://github.com/lunn/linux.git v3.7-rc2-pinctrl-v2

Valentin Longchamp (2):
  ARM: support 98DX412x kirkwoods with pinctrl
  ARM: convert the km_kirkwood board to pinctrl

 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |   39 ++
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |   31 ++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   17 +
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |   11 -
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c           |  568 ++++++++++----------
 5 files changed, 377 insertions(+), 289 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-98dx4122.dtsi
