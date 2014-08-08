From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  8 Aug 2014 12:18:50 -0300
Subject: [PATCH 0/6] mvebu: Network devicetree pin muxing
Message-ID: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the proper devicetree pin muxing for the network interfaces
on all Armada 370 boards.

The MDIO interface uses pins MPP17 and MPP18, and so this is needed
on all devices using MDIO.

For the ethernet interfaces, only the boards connecting with RGMII
need the mux. On this SoC, the SGMII is available on dedicated SerDes lanes,
and so no MPP pin mux is required.

The only board which uses SGMII is the Armada 370 Reference Design board.

This has been tested on Armada 370 Mirabox only, using the recently submitted
mvneta support for barebox. The series is based on v3.16.

Ezequiel Garcia (6):
  ARM: mvebu: Add required ethernet muxing for the Armada 370 SoC
  ARM: mvebu: Add proper pin muxing on Globalscale Mirabox board
  ARM: mvebu: Add proper pin muxing on the Armada 370 DB board
  ARM: mvebu: Add proper pin muxing on Netgear ReadyNAS 102
  ARM: mvebu: Add proper pin muxing on Netgear ReadyNAS 104
  ARM: mvebu: Add proper pin muxing on Armada 370 RD board

 arch/arm/boot/dts/armada-370-db.dts            |  6 ++++++
 arch/arm/boot/dts/armada-370-mirabox.dts       |  6 ++++++
 arch/arm/boot/dts/armada-370-netgear-rn102.dts |  4 ++++
 arch/arm/boot/dts/armada-370-netgear-rn104.dts |  6 ++++++
 arch/arm/boot/dts/armada-370-rd.dts            |  4 ++++
 arch/arm/boot/dts/armada-370.dtsi              | 19 +++++++++++++++++++
 6 files changed, 45 insertions(+)

-- 
2.0.1
