From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:25 +0530
Subject: [PATCH 00/50] pinctrl: Add and use devm_ apis for pinctrl_{register,
 unregister}
Message-ID: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resource manageemnt APIs fro pinctrl_register() and pinctrl_unregister()
and use these new APIs on hw driver to reduce the error path code and
remove callback for driver.

Laxman Dewangan (50):
  pinctrl: Add devm_ apis for pinctrl_{register, unregister}
  pinctrl: Add resource management devm_pinctrl_{register, unregister}
  pinctrl: bcm281xx: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: bcm2835: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: cygnus-mux: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: iproc-gpio: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: nsp-gpio: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: berlin: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: imx: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: imxl: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: cherryview: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: intel: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: mtk-common: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: meson: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: mvebu: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: nomadic: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: spmi-gpio: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: spmi: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: ssbi-gpi: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: ssbi-mpp: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: msm: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: pxa: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: exynos5440: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: samsung: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: ish-pfc: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: spear: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: stm32: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: ssbi-mpp: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: tegra: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: tegra-xusb: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: uniphier: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: vt8500: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: adi2: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: amd: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: as3722: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: at91-pio4: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: at91: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: digicolor: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: lantiq: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: lpc18xx: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: palmas: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: pic32: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: pistachio: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: rockchip: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: st: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: tb10x: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: tz1090-pdc: Use devm_pinctrl_register() for pinctrl
    registration
  pinctrl: tz1090 Use devm_pinctrl_register() for pinctrl registration
  pinctrl: u300: Use devm_pinctrl_register() for pinctrl registration
  pinctrl: zynq: Use devm_pinctrl_register() for pinctrl registration

 Documentation/driver-model/devres.txt            |  2 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c           |  4 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c            |  3 +-
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c         |  2 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c         | 12 +----
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c           |  2 +-
 drivers/pinctrl/berlin/berlin.c                  |  3 +-
 drivers/pinctrl/core.c                           | 69 ++++++++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-imx.c          | 11 +---
 drivers/pinctrl/freescale/pinctrl-imx.h          |  1 -
 drivers/pinctrl/freescale/pinctrl-imx1-core.c    | 11 +---
 drivers/pinctrl/freescale/pinctrl-imx1.c         |  1 -
 drivers/pinctrl/freescale/pinctrl-imx1.h         |  1 -
 drivers/pinctrl/freescale/pinctrl-imx21.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx25.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx27.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx35.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx50.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx51.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx53.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx6dl.c       |  1 -
 drivers/pinctrl/freescale/pinctrl-imx6q.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-imx6sl.c       |  1 -
 drivers/pinctrl/freescale/pinctrl-imx6sx.c       |  1 -
 drivers/pinctrl/freescale/pinctrl-imx6ul.c       |  1 -
 drivers/pinctrl/freescale/pinctrl-imx7d.c        |  1 -
 drivers/pinctrl/freescale/pinctrl-vf610.c        |  1 -
 drivers/pinctrl/intel/pinctrl-cherryview.c       |  4 +-
 drivers/pinctrl/intel/pinctrl-intel.c            |  4 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c    | 17 +++---
 drivers/pinctrl/meson/pinctrl-meson.c            |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c       |  6 ---
 drivers/pinctrl/mvebu/pinctrl-armada-375.c       |  6 ---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c       |  6 ---
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c       |  6 ---
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c        |  6 ---
 drivers/pinctrl/mvebu/pinctrl-dove.c             |  5 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c         |  6 ---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c            |  9 +---
 drivers/pinctrl/nomadik/pinctrl-abx500.c         |  3 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c        |  2 +-
 drivers/pinctrl/pinctrl-adi2.c                   | 13 +----
 drivers/pinctrl/pinctrl-amd.c                    |  9 ++--
 drivers/pinctrl/pinctrl-as3722.c                 |  9 ++--
 drivers/pinctrl/pinctrl-at91-pio4.c              | 26 ++++-----
 drivers/pinctrl/pinctrl-at91.c                   | 13 +----
 drivers/pinctrl/pinctrl-digicolor.c              |  7 +--
 drivers/pinctrl/pinctrl-lantiq.c                 |  2 +-
 drivers/pinctrl/pinctrl-lpc18xx.c                |  3 +-
 drivers/pinctrl/pinctrl-palmas.c                 | 12 +----
 drivers/pinctrl/pinctrl-pic32.c                  |  3 +-
 drivers/pinctrl/pinctrl-pistachio.c              |  4 +-
 drivers/pinctrl/pinctrl-rockchip.c               |  2 +-
 drivers/pinctrl/pinctrl-st.c                     |  2 +-
 drivers/pinctrl/pinctrl-tb10x.c                  |  3 +-
 drivers/pinctrl/pinctrl-tz1090-pdc.c             | 13 +----
 drivers/pinctrl/pinctrl-tz1090.c                 | 13 +----
 drivers/pinctrl/pinctrl-u300.c                   | 12 +----
 drivers/pinctrl/pinctrl-zynq.c                   | 12 +----
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c             | 10 +---
 drivers/pinctrl/qcom/pinctrl-msm.c               |  8 ++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c         |  7 +--
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c          |  7 +--
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c         |  9 +---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c          |  9 +---
 drivers/pinctrl/samsung/pinctrl-exynos5440.c     |  2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c        |  3 +-
 drivers/pinctrl/sh-pfc/core.c                    |  1 -
 drivers/pinctrl/sh-pfc/core.h                    |  1 -
 drivers/pinctrl/sh-pfc/pinctrl.c                 | 12 +----
 drivers/pinctrl/spear/pinctrl-spear.c            | 11 +---
 drivers/pinctrl/spear/pinctrl-spear.h            |  1 -
 drivers/pinctrl/spear/pinctrl-spear1310.c        |  6 ---
 drivers/pinctrl/spear/pinctrl-spear1340.c        |  6 ---
 drivers/pinctrl/spear/pinctrl-spear300.c         |  6 ---
 drivers/pinctrl/spear/pinctrl-spear310.c         |  6 ---
 drivers/pinctrl/spear/pinctrl-spear320.c         |  6 ---
 drivers/pinctrl/stm32/pinctrl-stm32.c            |  7 +--
 drivers/pinctrl/sunxi/pinctrl-sunxi.c            | 13 ++---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c       | 13 ++---
 drivers/pinctrl/tegra/pinctrl-tegra.c            | 12 +----
 drivers/pinctrl/tegra/pinctrl-tegra.h            |  2 -
 drivers/pinctrl/tegra/pinctrl-tegra114.c         |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra124.c         |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra20.c          |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra210.c         |  1 -
 drivers/pinctrl/tegra/pinctrl-tegra30.c          |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c       |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c      |  1 -
 drivers/pinctrl/uniphier/pinctrl-proxstream2.c   |  1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 12 +----
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  2 -
 drivers/pinctrl/vt8500/pinctrl-wmt.c             |  7 +--
 include/linux/pinctrl/pinctrl.h                  |  6 +++
 97 files changed, 179 insertions(+), 393 deletions(-)

-- 
2.1.4
