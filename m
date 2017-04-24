From: eric@anholt.net (Eric Anholt)
Date: Mon, 24 Apr 2017 14:50:20 -0700
Subject: [PATCH 0/2] net: dsa: b53: BCM11360 support
Message-ID: <20170424215022.30382-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This little patch series follows on from Florian's fixes that he just
sent, and enables the ethernet on the 911360_EP board.

Without Florian's fixes, the controller comes up and forwarding
happens between eth1 and eth2, but the CPU's eth0 packets don't get
forwarded.

Eric Anholt (2):
  net: dsa: b53: Add compatible strings for the Cygnus-family BCM11360.
  ARM: dts: Add the ethernet and ethernet PHY to the cygnus core DT.

 Documentation/devicetree/bindings/net/dsa/b53.txt |  3 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                 | 60 +++++++++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts            |  8 +++
 drivers/net/dsa/b53/b53_srab.c                    |  2 +
 4 files changed, 73 insertions(+)

-- 
2.11.0
