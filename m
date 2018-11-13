From: Andrei.Stefanescu@microchip.com (Andrei.Stefanescu at microchip.com)
Date: Tue, 13 Nov 2018 11:29:15 +0000
Subject: [PATCH 0/3] add support for MCP16502 PMIC
Message-ID: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MCP16502 is a Power Management IC from Microchip.
It has 4 Buck outputs and 2 LDOs. The buck regulators
can be used in two modes: normal(FPWM) and low-power(Auto PFM).

This patch series adds support for the MCP16502 PMIC.

Andrei Stefanescu (3):
  regulator: dt-bindings: add MCP16502 regulator bindings
  MAINTAINERS: add maintainer for MCP16502 PMIC driver
  regulator: mcp16502: add regulator driver for MCP16502

 .../bindings/regulator/mcp16502-regulator.txt      | 107 +++++
 MAINTAINERS                                        |   7 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mcp16502.c                       | 524 +++++++++++++++++++++
 5 files changed, 648 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 create mode 100644 drivers/regulator/mcp16502.c

-- 
2.7.4
