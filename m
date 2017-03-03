From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  3 Mar 2017 11:45:51 +0100
Subject: [PATCH v2] nvmem: i.MX IIM driver
Message-ID: <20170303104553.18477-1-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This adds a readonly nvmem driver for the i.MX IC Identification Module (IIM)
which is found on the older i.MX SoCs. The IIM is part of the i.MX dts files
for long now, but so far there is no binding document for it, so add one now.

Sascha

Changes since v1:
- Fix unterminated array as reported by kbuild

----------------------------------------------------------------
Michael Grzeschik (1):
      nvmem: Add driver for the i.MX IIM

Sascha Hauer (1):
      dt-bindings: nvmem: Add i.MX IIM binding doc

 .../devicetree/bindings/nvmem/imx-iim.txt          |  22 +++
 drivers/nvmem/Kconfig                              |  11 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/imx-iim.c                            | 173 +++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt
 create mode 100644 drivers/nvmem/imx-iim.c
