From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:32:21 +0100
Subject: [PATCH v2 00/13] Various Armada 375 DT warning fixup
Message-ID: <20161113213234.3368-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In the second version as for the Armada 370/XP series the main change
is the use of the target and attributes property of the memory windows
when MBUS_ID is involved. Indeed, by adding this information to the
unit-address is really uniq as required by the ePAPR as explained in
this email:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/466941.html.

The other change is the merged of the patch 7 and 8 of the first version.

Gregory

Gregory CLEMENT (13):
  ARM: dts: armada-375: Add node labels
  ARM: dts: armada-375: Use the node labels
  ARM: dts: armada-375: Fixup mdio DT warning
  ARM: dts: armada-375: Fixup bootrom DT warning
  ARM: dts: armada-375: Fixup devbus DT warning
  ARM: dts: armada-375: Fixup sa-ram DT warning
  ARM: dts: armada-375: Fixup pcie DT warnings
  ARM: dts: armada-375: Fixup pinctrl DT warnings
  ARM: dts: armada-375: Fixup soc DT warning
  ARM: dts: armada-375: Fixup internal-regs DT warning
  ARM: dts: armada-375: Remove skeleton.dtsi
  ARM: dts: armada-375: Fixup memory DT warning
  ARM: dts: armada-375: Fixup ethernet child DT warning

 arch/arm/boot/dts/armada-375-db.dts | 273 ++++++++++++++++++------------------
 arch/arm/boot/dts/armada-375.dtsi   |  80 +++++------
 2 files changed, 179 insertions(+), 174 deletions(-)

-- 
2.10.2
