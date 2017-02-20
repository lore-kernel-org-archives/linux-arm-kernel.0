From: yannick.fertre@st.com (Yannick Fertre)
Date: Mon, 20 Feb 2017 17:08:34 +0100
Subject: [PATCH v3 0/7] STM32 LCD-TFT display controller
Message-ID: <1487606921-26981-1-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 3:
- Update "st,stm32-ltdc.txt" binding.
- Add a commit to "ARM: configs: stm32: ADD LDTC support" patch.

Version 2:
- Rename driver directory from st to stm.
- Rename compatiblity from st,ltdc to st,stm32-ltdc.
- Remove compatibility st,display-subsystem.
- Rename driver from st-drm to stm-drm.
- Rework probe sequence & remove display-subsystem part.
- I keep clock name which is necessary for devm_regmap_init_mmio_clk call.

Version 1:
- Initial commit

The purpose of this set of patches is to add a new driver for stm32f429.
This driver was developed and tested on evaluation board stm32429i.

Stm32f4 is a MCU platform which don't have MMU so the last patches developed
by Benjamin Gaignard regarding "DRM: allow to use mmuless devices"
are necessary.

The board stm429i embeds a Ampire AM-480272H3TMQW-T01H screen.
A new simple panel am-480272h3tmqw-t01h have been added to support it.

Yannick Fertre (7):
  dt-bindings: display: add STM32 LTDC driver
  drm/st: Add STM32 LTDC driver
  dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
  drm/panel: simple: Add support for Ampire AM-480272H3TMQW-T01H
  ARM: dts: stm32: Add ltdc support on stm32f429 MCU
  ARM: dts: stm32: Enable ltdc & simple panel on stm32f429-Eval board
  ARM: configs: stm32: ADD LDTC support

 .../display/panel/ampire,am-480272h3tmqw-t01h.txt  |    7 +
 .../devicetree/bindings/display/st,stm32-ltdc.txt  |   36 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   59 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   19 +-
 arch/arm/configs/stm32_defconfig                   |    5 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/panel/panel-simple.c               |   29 +
 drivers/gpu/drm/stm/Kconfig                        |   14 +
 drivers/gpu/drm/stm/Makefile                       |    7 +
 drivers/gpu/drm/stm/drv.c                          |  232 ++++
 drivers/gpu/drm/stm/drv.h                          |   24 +
 drivers/gpu/drm/stm/ltdc.c                         | 1381 ++++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.h                         |   22 +
 14 files changed, 1837 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
 create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
 create mode 100644 drivers/gpu/drm/stm/Kconfig
 create mode 100644 drivers/gpu/drm/stm/Makefile
 create mode 100644 drivers/gpu/drm/stm/drv.c
 create mode 100644 drivers/gpu/drm/stm/drv.h
 create mode 100644 drivers/gpu/drm/stm/ltdc.c
 create mode 100644 drivers/gpu/drm/stm/ltdc.h

-- 
1.9.1
