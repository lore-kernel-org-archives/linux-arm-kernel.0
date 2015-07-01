From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed,  1 Jul 2015 14:45:50 +0200
Subject: [PATCH v1 0/3] Have Tegra's GPIO chip depend explicitly on the
 pinctrl device
Message-ID: <1435754753-31307-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

these three patches make sure that there's an explicit dependency from
the GPIO chip in Tegra SoCs to the corresponding pinctrl device, without
having duplicated gpio ranges.

By having an explicit dependency, we can do things such as probing the
pinctrl device before the GPIO chip device to avoid deferred probes.

Thanks,

Tomeu


Tomeu Vizoso (3):
  gpio: defer probe if pinctrl cannot be found
  pinctrl: tegra: Only set the gpio range if needed
  ARM: tegra: Add gpio-ranges property

 arch/arm/boot/dts/tegra114.dtsi |  1 +
 arch/arm/boot/dts/tegra124.dtsi |  1 +
 arch/arm/boot/dts/tegra20.dtsi  |  1 +
 arch/arm/boot/dts/tegra30.dtsi  |  1 +
 drivers/gpio/gpiolib-of.c       | 27 ++++++++++++++++++---------
 drivers/gpio/gpiolib.c          |  5 ++++-
 drivers/pinctrl/pinctrl-tegra.c | 19 ++++++++++++++++++-
 include/linux/of_gpio.h         |  4 ++--
 8 files changed, 46 insertions(+), 13 deletions(-)

-- 
2.4.1
