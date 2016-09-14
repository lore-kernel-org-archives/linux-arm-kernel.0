From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:38 +0100
Subject: [PATCH 00/19] [RESEND] Remove STiH415 and STiH416 SoC platform support
Message-ID: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending due to incorrect Cc tags.

ST have sent patches which remove clock support for these SoCs [1]
which once applied mean the platform will no longer boot.

This series cleans up various STi platform drivers which have
support for these SoC's, by removing code, and updating the DT
documentation accordingly. Some drivers such as miphy365 and
stih41x-usb can be removed completely because the IP is only
found on these legacy SoC's.

Once this series is applied, drm display driver, and ALSA SoC
are the main two remaining references to the legacy SoCs, other
than clocks which already have patches on the ML.

regards,

Peter.

[1] https://patchwork.kernel.org/patch/9157571/

Peter Griffin (19):
  phy: phy-miphy365x: Remove miphy365 driver and dt binding
    documentation.
  phy: stih41x-usb: Remove usb phy driver and dt binding documentation.
  MAINTAINERS: Remove phy-miphy365x.c entry from STi arch
  MAINTAINERS: Remove phy-stih41x-usb.c entry from STi arch
  ARM: multi_v7_defconfig: Remove miphy365 phy.
  ARM: multi_v7_defconfig: Remove stih41x phy Kconfig symbol.
  ahci: st: Remove STiH416 dt example
  thermal: sti: Remove obsolete platforms from the DT doc.
  thermal: sti: Remove obsolete STiH416 platform support.
  watchdog: bindings: Remove obsolete platforms from dt doc.
  watchdog: st_wdt: Remove support for obsolete platforms
  reset: sti: Remove obsolete platforms from dt binding doc.
  pinctrl: st: Remove STiH415/6 SoC pinctrl driver support.
  pinctrl: st: Remove obsolete platforms from pinctrl-st dt doc
  reset: sti: Remove STiH415/6 reset support
  power: reset: st-poweroff: Remove obsolete platforms.
  power: reset: st: Remove obsolete platforms from dt doc
  stmmac: dwmac-sti: Remove obsolete STi platforms
  reset: sti: softreset: Remove obsolete platforms from dt binding doc.

 Documentation/devicetree/bindings/ata/ahci-st.txt  |  15 -
 .../devicetree/bindings/net/sti-dwmac.txt          |   3 +-
 .../devicetree/bindings/phy/phy-miphy365x.txt      |  77 ---
 .../devicetree/bindings/phy/phy-stih41x-usb.txt    |  24 -
 .../devicetree/bindings/pinctrl/pinctrl-st.txt     |  33 +-
 .../devicetree/bindings/power/reset/st-reset.txt   |   7 +-
 .../devicetree/bindings/reset/st,sti-powerdown.txt |  12 +-
 .../devicetree/bindings/reset/st,sti-softreset.txt |   8 +-
 .../devicetree/bindings/thermal/st-thermal.txt     |  28 +-
 .../devicetree/bindings/watchdog/st_lpc_wdt.txt    |   3 +-
 MAINTAINERS                                        |   2 -
 arch/arm/configs/multi_v7_defconfig                |   2 -
 arch/arm/mach-sti/Kconfig                          |   2 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  37 --
 drivers/phy/Kconfig                                |  18 -
 drivers/phy/Makefile                               |   2 -
 drivers/phy/phy-miphy365x.c                        | 625 ---------------------
 drivers/phy/phy-stih41x-usb.c                      | 188 -------
 drivers/pinctrl/pinctrl-st.c                       |  76 +--
 drivers/power/reset/st-poweroff.c                  |  41 --
 drivers/reset/sti/Kconfig                          |   8 -
 drivers/reset/sti/Makefile                         |   2 -
 drivers/reset/sti/reset-stih415.c                  | 112 ----
 drivers/reset/sti/reset-stih416.c                  | 143 -----
 drivers/thermal/st/st_thermal_memmap.c             |  34 +-
 drivers/watchdog/st_lpc_wdt.c                      |  33 --
 26 files changed, 65 insertions(+), 1470 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
 delete mode 100644 drivers/phy/phy-miphy365x.c
 delete mode 100644 drivers/phy/phy-stih41x-usb.c
 delete mode 100644 drivers/reset/sti/reset-stih415.c
 delete mode 100644 drivers/reset/sti/reset-stih416.c

-- 
1.9.1
