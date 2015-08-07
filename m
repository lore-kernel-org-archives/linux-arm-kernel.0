From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  7 Aug 2015 11:48:19 +0200
Subject: [PATCH v2 0/2] i.MX6 OCOTP NVMEM support
Message-ID: <1438940901-5779-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add support for the i.MX On-Chip OTP (eFuse) Controller found
in i.MX6Q/D, i.MX6S/DL, i.MX6SL, and i.MX6SX SoCs to the NVMEM framework.
Greg, could you take them into the char-misc tree together with the NVMEM
framework?

Changes since v1:
 - Dropped unneeded clk.h include
 - Fixed MODULE_LICENSE
 - Droped third patch (adding the clock to the device tree node can be done separately)

Philipp Zabel (2):
  nvmem: Add i.MX6 OCOTP device tree binding documentation
  nvmem: imx-ocotp: Add i.MX6 OCOTP driver

 .../devicetree/bindings/nvmem/imx-ocotp.txt        |  20 +++
 drivers/nvmem/Kconfig                              |  11 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/imx-ocotp.c                          | 154 +++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
 create mode 100644 drivers/nvmem/imx-ocotp.c

-- 
2.4.6

regards
Philipp
