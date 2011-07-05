From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Jul 2011 23:26:05 +0800
Subject: [PATCH v2 0/3] Add device tree probe for sdhci-esdhc-imx
Message-ID: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes the uses of cpu_is_mx(), the second one makes
a dt related fix on sdhci-pltfm.c, and the third one adds device tree
probe for sdhci-esdhc-imx driver.

Changes since v1:
 * Address review comments given by Grant

Shawn Guo (3):
      mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
      mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
      mmc: sdhci-esdhc-imx: add device tree probe support

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   40 ++++++
 arch/arm/mach-imx/clock-imx25.c                    |    4 +-
 arch/arm/mach-imx/clock-imx35.c                    |    6 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   16 +-
 arch/arm/mach-mx5/mx51_efika.c                     |    4 +-
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   17 ++-
 arch/arm/plat-mxc/include/mach/devices-common.h    |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  144 ++++++++++++++++++--
 drivers/mmc/host/sdhci-pltfm.c                     |    3 +-
 9 files changed, 202 insertions(+), 33 deletions(-)
