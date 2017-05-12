From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 12 May 2017 20:38:00 +0800
Subject: [PATCH 0/5] pinctrl: imx: add generic pin config and imx7ulp support
Message-ID: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series intends to add the generic pin config support for imx
platforms.

The design is based on the exist architecture that the core will
provide a uniformed way to decode the generic pin config into platform
config register raw data according to the imx_cfg_params_decode maps
registered by platform.

Two useful macros, IMX_CFG_PARAMS_DECODE and IMX_CFG_PARAMS_DECODE_INVERT,
are created for platform to register decode map conveniently.

In order to cope with some special case, a platform specific fixup()
function is also available to use.

The series also added the imx7ulp pinctrl support which only supports
generic pin config.

Dong Aisheng (5):
  pinctrl: imx: add generic pin config core support
  pinctrl: imx: add soc specific mux_mode mask and shift property
  dt-bindings: pinctrl: add imx7ulp pinctrl binding doc
  pinctrl: imx: add imx7ulp driver
  pinctrl: imx: fix debug message for SHARE_MUX_CONF_REG case

 .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       |  56 +++
 drivers/pinctrl/freescale/Kconfig                  |   9 +-
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx.c            | 128 +++++-
 drivers/pinctrl/freescale/pinctrl-imx.h            |  29 ++
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c        | 358 ++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-vf610.c          |   2 +
 include/dt-bindings/pinctrl/imx7ulp-pinfunc.h      | 468 +++++++++++++++++++++
 8 files changed, 1030 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx7ulp.c
 create mode 100644 include/dt-bindings/pinctrl/imx7ulp-pinfunc.h

-- 
2.7.4
