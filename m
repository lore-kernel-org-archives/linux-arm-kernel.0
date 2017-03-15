From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 15 Mar 2017 18:02:06 +0100
Subject: [PATCH v4 0/8] STM32 LCD-TFT display controller
Message-ID: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 4:
- Update "ampire,am-480272h3tmqw-t01h.txt" binding with more details on gpios.
- Update ltdc.c. Remove regmap, solve some typo & warnings.

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

Yannick Fertre (8):
  dt-bindings: display: add STM32 LTDC driver
  drm/stm: Add STM32 LTDC driver
  dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
  drm/panel: simple: Add support for Ampire AM-480272H3TMQW-T01H
  ARM: dts: stm32: Add ltdc support on stm32f429 MCU
  ARM: dts: stm32: Enable ltdc & simple panel on stm32f429-Eval board
  ARM: configs: Add STM32 LTDC support in STM32 defconfig
  ARM: configs: Add STM32 panel simple support in STM32 defconfig

 .../display/panel/ampire,am-480272h3tmqw-t01h.txt  |   26 +
 .../devicetree/bindings/display/st,stm32-ltdc.txt  |   36 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   59 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   19 +-
 arch/arm/configs/stm32_defconfig                   |    3 +
 drivers/gpu/drm/Kconfig                            |    3 +-
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/panel/panel-simple.c               |   29 +
 drivers/gpu/drm/stm/Kconfig                        |   16 +
 drivers/gpu/drm/stm/Makefile                       |    7 +
 drivers/gpu/drm/stm/drv.c                          |  232 ++++
 drivers/gpu/drm/stm/drv.h                          |   22 +
 drivers/gpu/drm/stm/ltdc.c                         | 1422 ++++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.h                         |   22 +
 14 files changed, 1895 insertions(+), 2 deletions(-)
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
