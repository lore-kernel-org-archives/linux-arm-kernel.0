From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  3 Jul 2011 16:30:48 +0800
Subject: [PATCH 0/3] Add device tree probe for sdhci-esdhc-imx
Message-ID: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes the uses of cpu_is_mx(), and can be merged
right away when review gets done.

The second patch makes an independent fix on sdhci-pltfm.c which can
be merged if it looks right to the gate keeper.

The third patch adds device tree probe.  It uses the newly added dt
api of_property_read_string which is sitting on Grant's devicetree/next
branch with the out_string 'const' thing as a question mark.

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
