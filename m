From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 19 May 2017 17:20:13 +0200
Subject: [PATCH v2 0/5] STM32 DSI HOST
Message-ID: <1495207218-11372-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 2:
- Add a generic Synopsys DesignWare MIPI DSI bridge driver following
  comments from Neil Armstrong & Archit Taneja.
- Use drm_of_find_panel_or_bridge() thanks to Eric Anholt comments
- Update dt-bindings thanks to Rob Herring comments

Version 1:
- Initial commit

The purpose of this set of patches is to add the mipi dsi host driver
to the stm32 family.

This mipi dsi host driver is based on the Rockchip version of the
Synopsys Designware mipi dsi driver (rockchip/dw-mipi-dsi.c)
modified for the stm32 family:
    - replace Rockchip digital & phy specific extensions with stm32's ones.
    - add a bridge

Philippe CORNU (5):
  drm/stm: ltdc: Add bridge support
  dt-bindings: display: Add Synopsys DW MIPI DSI DRM bridge driver
  drm/bridge/synopsys: Add MIPI DSI host controller bridge
  dt-bindings: display: Add STM32 DSI host driver
  drm/stm: Add STM32 DSI host driver

 .../bindings/display/bridge/dw_mipi_dsi.txt        |   36 +
 .../devicetree/bindings/display/st,stm32-ltdc.txt  |  102 +-
 drivers/gpu/drm/bridge/synopsys/Kconfig            |    9 +
 drivers/gpu/drm/bridge/synopsys/Makefile           |    2 +
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      | 1024 ++++++++++++++++++++
 drivers/gpu/drm/stm/Kconfig                        |    8 +
 drivers/gpu/drm/stm/Makefile                       |    2 +
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |  328 +++++++
 drivers/gpu/drm/stm/ltdc.c                         |   74 +-
 drivers/gpu/drm/stm/ltdc.h                         |    1 +
 10 files changed, 1565 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
 create mode 100644 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c

-- 
1.9.1
