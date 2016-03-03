From: blogic@openwrt.org (John Crispin)
Date: Thu,  3 Mar 2016 21:02:37 +0100
Subject: [PATCH V3 0/4] net-next: mediatek: add ethernet driver
Message-ID: <1457035361-57669-1-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the Mediatek ethernet core found on current ARM
based SoCs. The driver works on MT2701 and MT7623 SoCs

Instead of trying to upstream everything at once I decided to concentrate on
the important parts required to make current generation silicon work. The V3
series only includes the code required to make dual MAC setups work and only
supports the newer QDMA engine.

Changes in V3
* only include code for MT2701/7623 support
* drop support for PDMA and older MIPS based SoCs
* drop switch support

Changes in V2
* change the namespace of the functions from fe_* to mtk_*
* add support for the latest generation of ARM SoCs
* add dual MAC support
* remove the swconfig specific bits
* remove most of the magic values and replace them with defines
* add verbose descriptions to the patches

John Crispin (4):
  net-next: mediatek: document MediaTek SoC ethernet binding
  net-next: mediatek: add support for MT7623 ethernet
  net-next: mediatek: add Kconfig and Makefile
  net-next: mediatek: add an entry to MAINTAINERS

 .../devicetree/bindings/net/mediatek-net.txt       |   77 +
 MAINTAINERS                                        |    7 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/mediatek/Kconfig              |   17 +
 drivers/net/ethernet/mediatek/Makefile             |    5 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 1786 ++++++++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |  427 +++++
 8 files changed, 2321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-net.txt
 create mode 100644 drivers/net/ethernet/mediatek/Kconfig
 create mode 100644 drivers/net/ethernet/mediatek/Makefile
 create mode 100644 drivers/net/ethernet/mediatek/mtk_eth_soc.c
 create mode 100644 drivers/net/ethernet/mediatek/mtk_eth_soc.h

-- 
1.7.10.4
