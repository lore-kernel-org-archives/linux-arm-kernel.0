From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 22 Apr 2014 17:38:19 +0200
Subject: [PATCH 0/6] ARM: berlin: add AHCI support
Message-ID: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the support for Berlin SoCs AHCI controllers. The
controller allows to use the SATA host interface and, for example, the
eSATA port on the BG2Q.

Also enable the eSATA interface on the BG2Q DMP.

Tested on the BG2Q DMP.

Antoine T?nart (6):
  ata: ahci: add AHCI support for Berlin SoCs
  Documentation: bindings: add the berlin-achi compatible to the ahci
    platform
  ARM: berlin: add the AHCI node for the BG2Q
  ARM: berlin: enable the eSATA interface on the BG2Q DMP
  ARM: berlin: add the AHCI node for the BG2
  ARM: berlin: add the AHCI node for the BG2CD

 .../devicetree/bindings/ata/ahci-platform.txt      |   3 +-
 arch/arm/boot/dts/berlin2.dtsi                     |   7 +
 arch/arm/boot/dts/berlin2cd.dtsi                   |   7 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |   5 +
 arch/arm/boot/dts/berlin2q.dtsi                    |  12 ++
 drivers/ata/Kconfig                                |   9 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_berlin.c                          | 175 +++++++++++++++++++++
 8 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ata/ahci_berlin.c

-- 
1.8.3.2
