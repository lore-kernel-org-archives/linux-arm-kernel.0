From: stefan@agner.ch (Stefan Agner)
Date: Sat,  6 Jan 2018 15:25:48 +0100
Subject: [PATCH v2 0/5] constify struct imx_pinctrl_soc_info
Message-ID: <20180106142553.15322-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset grew out of the discussion around the first version
of "pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver for i.MX 6ULL".
This is necessary for pinctrls of SoCs with multiple compatible
strings (currently only imx7d) since the struct uses the .data
pointer in struct of_device_id. It is also helpful for all other
SoCs since it decreases the .data section for all drivers by 1276
bytes.

Bai Ping (1):
  pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver for i.MX 6ULL

Stefan Agner (4):
  pinctrl: imx: use struct imx_pinctrl_soc_info as a const
  pinctrl: imx7d: simplify imx7d_pinctrl_probe
  pinctrl: imx: constify struct imx_pinctrl_soc_info
  pinctrl: imx7ulp: constify struct imx_cfg_params_decode

 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        |  3 +-
 drivers/pinctrl/freescale/pinctrl-imx.c            | 81 ++++++++++------------
 drivers/pinctrl/freescale/pinctrl-imx.h            | 13 ++--
 drivers/pinctrl/freescale/pinctrl-imx25.c          |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx35.c          |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx50.c          |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx51.c          |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx53.c          |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx6dl.c         |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx6q.c          |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx6sl.c         |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx6sx.c         |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx6ul.c         | 52 ++++++++++++--
 drivers/pinctrl/freescale/pinctrl-imx7d.c          | 10 +--
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c        |  7 +-
 drivers/pinctrl/freescale/pinctrl-vf610.c          |  5 +-
 16 files changed, 111 insertions(+), 78 deletions(-)

-- 
2.15.1
