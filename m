From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 14 Jan 2014 15:50:04 +0100
Subject: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Message-ID: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
SoCs: once a disk is removed from a SATA port, then the re-plug events
are not detected by the sata_mv driver.

This should be applied to the -stable kernels 3.10 and onwards. 

Changes since v1:
- Introduces a new compatible string for the SATA IP found in Armada
  370/XP SoCs.
- Only fix the LP_PHY_CTL register (0x58) if the compatible string
  "marvell,armada-370-xp-sata" is found in the SATA DT node.
- Update compatible string in DT SATA node for Armada 370/XP SoCs. 

Thanks,

Simon

Lior Amsalem (1):
  ata: sata_mv: fix disk hotplug for Armada 370/XP SoCs

Simon Guinot (2):
  ata: sata_mv: introduce compatible string "marvell,armada-370-xp-sata"
  ARM: mvebu: update the SATA compatible string for Armada 370/XP

 Documentation/devicetree/bindings/ata/marvell.txt |  2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi              |  2 +-
 drivers/ata/sata_mv.c                             | 25 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>
Cc: stable at vger.kernel.org
-- 
1.8.5.2
