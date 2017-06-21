From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 21 Jun 2017 18:01:47 +0800
Subject: [RFC PATCH v3 0/6] Report wakeup events in cros_ec_keyb and make
 cros-ec-spi wakeup optional
Message-ID: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


We are enabling wakeup unconditionally for cros-ec-spi, it would be good to make it optional.

And we also need to enable wakeup for cros_ec_keyb, so the userspace could disable keyboard wakeup along with other cros-ec sub devices.


Changes in v3:
Use wakeup-source property to enable wakeup.
  Suggested by Dmitry Torokhov <dmitry.torokhov@gmail.com>.

Jeffy Chen (6):
  spi: core: add support for wakeup-source dts property
  dt-bindings: spi/core: add wakeup-source optional property
  ARM/arm64: dts: enable wakeup for cros-ec-spi devices
  mfd: cros ec: spi: remove unconditionally wakeup enable
  input: cros_ec_keyb: report wakeup events
  ARM: dts: cros-ec-keyboard: enable as wakeup source

 Documentation/devicetree/bindings/spi/spi-bus.txt |  1 +
 arch/arm/boot/dts/cros-ec-keyboard.dtsi           |  1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |  1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |  1 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi   |  1 +
 arch/arm/boot/dts/tegra124-nyan.dtsi              |  1 +
 arch/arm/boot/dts/tegra124-venice2.dts            |  1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts    |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      |  1 +
 drivers/input/keyboard/cros_ec_keyb.c             |  8 ++++++++
 drivers/mfd/cros_ec_spi.c                         |  2 --
 drivers/spi/spi.c                                 | 15 +++++++++++----
 12 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.1.4
