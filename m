From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 May 2015 21:23:21 +0200
Subject: [PATCH v2] Mediatek SCPSYS power domain support
Message-ID: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the MediaTek SCPSYS unit.

The SCPSYS unit handles several power management related tasks such
as thermal measurement, DVFS, interrupt filter and low level sleep
control.

The initial support only contains the generic power domain handling.
This is needed to turn on power to the different power domains.

The driver is quite straight forward now. Due to the lack of a better
place I have put it to drivers/soc/mediatek. As the SCPSYS unit has
several other tasks that also do not fit into some specific subsystem
this probably is a good place for this driver.

Please review, any input welcome.

Sascha

changes since v1:
- make MFG_ASYNC a subdomain of MFG_2D and MFG_2D a subdomain of MFG
- Add (now hopefully properly) infracfg register handling again
- Add clock handling
- Fix on/off mixup in error message
- Make readonly data const
- Fix MODULE_LICENSE to GPL v2

changes since RFC:

- add a commit log to driver patch
- drop manipulating infracfg registers for now, can be added (properly)
  later
- Add warning messages when errors occur
- add NULL pointer check for kmalloc


The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/sha/linux-2.6.git tags/v4.1-soc-mediatek-scpsys-v2

for you to fetch changes up to 455a45faa25fad4d89b8296d760048f243b72c7d:

  ARM64: MediaTek MT8173: Add SCPSYS device node (2015-05-11 14:32:59 +0200)

----------------------------------------------------------------
Sascha Hauer (5):
      soc: mediatek: Add infracfg misc driver support
      dt-bindings: soc: Add documentation for the MediaTek SCPSYS unit
      soc: Mediatek: Add SCPSYS power domain driver
      ARM64: MediaTek: Add generic pm domain support
      ARM64: MediaTek MT8173: Add SCPSYS device node

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  34 ++
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  12 +
 drivers/soc/mediatek/Kconfig                       |  17 +
 drivers/soc/mediatek/Makefile                      |   2 +
 drivers/soc/mediatek/mtk-infracfg.c                |  80 ++++
 drivers/soc/mediatek/mtk-scpsys.c                  | 416 +++++++++++++++++++++
 include/dt-bindings/power/mt8173-power.h           |  15 +
 8 files changed, 577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
 create mode 100644 drivers/soc/mediatek/mtk-infracfg.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
 create mode 100644 include/dt-bindings/power/mt8173-power.h
