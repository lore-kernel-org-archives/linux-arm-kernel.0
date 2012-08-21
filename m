From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 21 Aug 2012 16:47:26 +0530
Subject: [PATCH v3 0/4] Add AM33XX regulators device tree data
Message-ID: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add AM33XX regulators (tps65910/tps65217) device
tree data to am335x-evm and am335x-bone dts files. These patches
are based on Tony L "devel-dt" tree with these patches
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg73843.html
and these patches has been tested on AM335x EVM and Bone devices.

Changes from v2:
	- Added remaining regulator nodes with always on flag.
	  With out this flag regulator core calls for disable
	  regulators after init, which make device hang.
	- Modified tps65910 DTS entires with respect to tps65910
	  input supply.

Changes from v1:
	- Incorporated all Mark Brown's review comments on v1 by
	  * moving all the regulator constraints to corresponding
	    DTS file
	  * Regulator constraints are added according to board.
	- regulator name is added.

AnilKumar Ch (4):
  arm/dts: regulator: Add tps65910 device tree data
  arm/dts: regulator: Add tps65217 device tree data
  arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
  arm/dts: Add tps65217 regulator DT data to am335x-bone.dts

 arch/arm/boot/dts/am335x-bone.dts |   54 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts  |   94 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tps65217.dtsi   |   56 ++++++++++++++++++++++
 arch/arm/boot/dts/tps65910.dtsi   |   86 +++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

-- 
1.7.9.5
