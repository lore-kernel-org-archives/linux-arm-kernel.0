From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 11 Apr 2014 20:06:20 -0700
Subject: [PATCH v2 0/4] net: Add APM X-Gene SoC Ethernet driver support
Message-ID: <1397271984-23405-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the APM X-Gene SoC Ethernet driver.

v2
* Completely redesigned ethernet driver
* Added support to work with big endian kernel
* Renamed dtb phyid entry to phy_addr
* Changed dtb local-mac-address entry to byte string format
* Renamed dtb eth8clk entry to menetclk

v1
* Initial version

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Ravi Patel <rapatel@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
Iyappan Subramanian (4):
  MAINTAINERS: Add entry for APM X-Gene SoC ethernet driver
  Documentation: dts: Add bindings for APM X-Gene SoC ethernet driver
  dts: Add bindings for APM X-Gene SoC ethernet driver
  drivers: net: Add APM X-Gene SoC ethernet driver support.

 .../devicetree/bindings/net/apm-xgene-enet.txt     |   46 +
 MAINTAINERS                                        |    8 +
 arch/arm64/boot/dts/apm-mustang.dts                |    4 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |   18 +-
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/apm/Kconfig                   |    1 +
 drivers/net/ethernet/apm/Makefile                  |    5 +
 drivers/net/ethernet/apm/xgene/Kconfig             |   10 +
 drivers/net/ethernet/apm/xgene/Makefile            |    6 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |  829 +++++++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  383 ++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |  927 ++++++++++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  153 ++++
 14 files changed, 2389 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 create mode 100644 drivers/net/ethernet/apm/Kconfig
 create mode 100644 drivers/net/ethernet/apm/Makefile
 create mode 100644 drivers/net/ethernet/apm/xgene/Kconfig
 create mode 100644 drivers/net/ethernet/apm/xgene/Makefile
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_main.c
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_main.h

-- 
1.7.9.5
