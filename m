From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 12 May 2017 16:56:26 +0200
Subject: [PATCH v1 0/3] STM32 DSI HOST
Message-ID: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this set of patches is to add the mipi dsi host driver
to the stm32 family.

This mipi dsi host driver is based on the Rockchip version of the
Synopsys Designware mipi dsi driver (rockchip/dw-mipi-dsi.c)
modified for the stm32 family:
    - replace Rockchip digital & phy specific extensions with stm32's ones.
    - add a bridge

Philippe CORNU (3):
  drm/stm: ltdc: Add bridge support
  dt-bindings: display: Add STM32 DSI host driver
  drm/stm: Add STM32 DSI host driver

 .../devicetree/bindings/display/st,stm32-ltdc.txt  |   92 +-
 drivers/gpu/drm/stm/Kconfig                        |    7 +
 drivers/gpu/drm/stm/Makefile                       |    2 +
 drivers/gpu/drm/stm/dw-mipi-dsi.c                  | 1197 ++++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.c                         |   82 +-
 drivers/gpu/drm/stm/ltdc.h                         |    1 +
 6 files changed, 1368 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/stm/dw-mipi-dsi.c

-- 
1.9.1
