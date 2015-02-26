From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 26 Feb 2015 16:28:28 +0800
Subject: [PATCH v3 0/2] ARM: imx6sx-sdb: add revb board
Message-ID: <1424939310-19282-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v3:
- Rebased on v4.0-rc1

Changes for v2:

- Add missing Makefile entries for both dts files. [Patch 1/2] and [Patch 2/2]
- Delete OOP setting changed at imx6sx-sdb-reva, it is SoC feature,
  it doesn't need to be change unless board limitations. [Patch 1/2]
- Add explanation why OOP setting need to changed at imx6sx-sdb revb board. [Patch 2/2]
- Make imx6sx-sdb revb board as default imx6sx-sdb board. [Patch 2/2]

Hi Shawn,

The imx6sx-sdb board has two revisions, the current mainline is the
reva which is experimental and will not be released, the revb board
is used widely for internal and external users.

The main changes between reva and revb board:
- OOP setting
- pfuse
- qspi
- can transceiver (not mainlined)

Peter Chen (2):
  ARM: imx6sx-sdb: change default board as reva board
  ARM: imx6sx-sdb: add revb board and make it default

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/imx6sx-sdb-reva.dts | 143 ++++++++
 arch/arm/boot/dts/imx6sx-sdb.dts      | 603 ++--------------------------------
 arch/arm/boot/dts/imx6sx-sdb.dtsi     | 562 +++++++++++++++++++++++++++++++
 4 files changed, 734 insertions(+), 575 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-reva.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dtsi

-- 
1.9.1
