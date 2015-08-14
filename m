From: liguozhu@hisilicon.com (Kenneth Lee)
Date: Fri, 14 Aug 2015 18:30:17 +0800
Subject: [PATCH 0/5] net: Hisilicon Network Subsystem support
Message-ID: <1439548222-231611-1-git-send-email-liguozhu@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add Hisilicon Network Subsystem support. The subsystem
provides a long term developing network accelerate engine with ring buffer
interface. The network interface can be used as standard ethernet network
interface card or be made use by a network application with decoded L2 to
L4 data.

The patchset is porting from some internal-use drivers, it is tested and
working fine with the hardware. But some detail design is not that good.
But we want to know if the community can accept the structure/arch before
refining it. Thank you.

Kenneth Lee (5):
  net: add Hisilicon Network Subsystem support (config and documents)
  net: add Hisilicon Network Subsystem hnae framework support
  net: add Hisilicon Network Subsystem MDIO support
  net: add Hisilicon Network Subsystem DSAF support
  net: add Hisilicon Network Subsystem basic ethernet support

 .../devicetree/bindings/net/hisilicon-hns-dsaf.txt |   40 +
 .../devicetree/bindings/net/hisilicon-hns-mdio.txt |   22 +
 .../devicetree/bindings/net/hisilicon-hns-nic.txt  |   14 +
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi       |  197 ++
 drivers/net/ethernet/hisilicon/Kconfig             |   33 +-
 drivers/net/ethernet/hisilicon/Makefile            |    1 +
 drivers/net/ethernet/hisilicon/hns/Makefile        |   15 +
 drivers/net/ethernet/hisilicon/hns/hnae.c          |  494 ++++
 drivers/net/ethernet/hisilicon/hns/hnae.h          |  582 +++++
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |  766 ++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  705 +++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.h |   45 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  942 +++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |  462 ++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2681 ++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |  438 ++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  311 +++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.h |   45 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  582 +++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |  105 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  972 +++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |  136 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  958 +++++++
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  826 ++++++
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.h    |   15 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      | 1552 +++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_enet.h      |   81 +
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 1174 +++++++++
 drivers/net/ethernet/hisilicon/hns/hns_mdio_main.c |  597 +++++
 29 files changed, 14790 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
 create mode 100644 drivers/net/ethernet/hisilicon/hns/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hnae.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hnae.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_enet.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_enet.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns/hns_mdio_main.c

-- 
1.9.1
