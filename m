From: lho@apm.com (Loc Ho)
Date: Mon, 25 Nov 2013 22:46:54 -0700
Subject: [PATCH v3 0/4] PHY: Add APM X-Gene SoC 15Gbps Multi-purpose PHY
 support
Message-ID: <1385444818-29682-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHY: Add APM X-Gene SoC 15Gbps Multi-purpose PHY support

This patch adds support for APM X-Gene SoC 15Gbps Multi-purpose PHY. This
is the physical layer interface for the corresponding host controller. This
driver uses the new PHY generic framework posted by Kishon Vijay Abrahm.
In addition, the new PHY generic framework is patched to provide an
function to set the speed of the PHY.

v3
* Major re-write of the code based on various review comments
* Support external clock only at the moment
* Support SATA mode only at the moment
* No UEFI support at the moment

v2
* Remove port knowledge from functions
* Make all functions static
* Remove ID completely
* Make resource requirement based on compatible type
* Rename override PHY parameters with more descriptive name
* Add override PHY parameter for per controller, per port, and per speed
* Patch the generic PHY frame to expose set_speed operation

v1
* Initial version

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
Loc Ho (4):
  PHY: Add function set_speed to generic PHY framework
  Documentation: Add APM X-Gene SoC 15Gbps Multi-purpose PHY driver
    binding documentation
  PHY: add APM X-Gene SoC 15Gbps Multi-purpose PHY driver
  arm64: Add APM X-Gene SoC 15Gbps Multi-purpose PHY DTS entries

 .../devicetree/bindings/ata/apm-xgene-phy.txt      |   89 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   31 +
 drivers/phy/Kconfig                                |    6 +
 drivers/phy/Makefile                               |    2 +
 drivers/phy/phy-core.c                             |   21 +
 drivers/phy/phy-xgene.c                            | 1838 ++++++++++++++++++++
 include/linux/phy/phy.h                            |    8 +
 7 files changed, 1995 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/apm-xgene-phy.txt
 create mode 100644 drivers/phy/phy-xgene.c
