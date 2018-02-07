From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  7 Feb 2018 14:45:46 +0100
Subject: [PATCH 0/7] ARM: davinci: add genpd support
Message-ID: <20180207134553.13510-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar et al,

please take a look at the following patches. They add a simple genpd
driver and use it in DT mode on da850 boards.

I was trying to use genpd in legacy mode too, but couldn't find neither
any interfaces nor users that would do that. For now I added a check in
arch/arm/mach-davinci/pm_domain.c that disables the clock pm setup if
we're using genpd.

This series applies on top of and has been tested with David Lechner's
for-bartosz branch. It fixes the clock look-up issues we faced with
lcdc and emac.

Bartosz Golaszewski (7):
  dt-bindings: soc: new driver for DaVinci genpd
  soc: davinci: new genpd driver
  ARM: davinci: don't setup pm_clk if we're using genpd
  ARM: dts: da850: add power controller nodes
  ARM: dts: da850: add power-domains properties to device nodes
  ARM: davinci: select generic power domains for DaVinci in DT mode
  ARM: davinci_all_defconfig: select the DaVinci genpd driver in DT mode

 .../bindings/soc/ti,davinci-pm-domains.txt         |  13 +++
 arch/arm/boot/dts/da850.dtsi                       |  46 ++++++++
 arch/arm/configs/davinci_all_defconfig             |   2 +
 arch/arm/mach-davinci/Kconfig                      |   1 +
 arch/arm/mach-davinci/pm_domain.c                  |   9 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/davinci/Kconfig                        |  16 +++
 drivers/soc/davinci/Makefile                       |   1 +
 drivers/soc/davinci/davinci_pm_domains.c           | 125 +++++++++++++++++++++
 10 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
 create mode 100644 drivers/soc/davinci/Kconfig
 create mode 100644 drivers/soc/davinci/Makefile
 create mode 100644 drivers/soc/davinci/davinci_pm_domains.c

-- 
2.16.1
