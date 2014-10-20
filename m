From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Oct 2014 10:31:17 -0500
Subject: [PATCHv2 0/2] ARM: dts: socfpga: fix booting with SD/MMC
Message-ID: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The SOCFPGA dev kit was hanging during bootup on the SD/MMC driver loading.
The first patch fixes the booting and the 2nd patch adds a regulator node
for the SD/MMC driver to use.

v2 diff(s): Patch 2/2 ARM: dts: socfpga: Add a 3.3V fixed regulator node
	- Move the regulator nodes to their respective board dts file and
	  correctly rename the regulator to match the schematic

Dinh Nguyen (2):
  ARM: dts: socfpga: Fix SD card detect
  ARM: dts: socfpga: Add a 3.3V fixed regulator node

 arch/arm/boot/dts/socfpga_arria5.dtsi         |  2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    | 14 ++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  | 13 ++++++++++++-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 14 ++++++++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.0.3
