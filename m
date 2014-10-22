From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 22 Oct 2014 14:07:37 -0500
Subject: [PATCHv4 0/3] ARM: dts: socfpga: fix booting with SD/MMC
Message-ID: <1414004860-17645-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The SOCFPGA dev kit was hanging during bootup on the SD/MMC driver loading.
The first patch fixes the booting and the 2nd patch adds a regulator node
for the SD/MMC driver to use.

v4 diff(s):
- Add a new patch to rename the GPIO IP DTS node
- Use &gpio1 to set status="okay"
- Update the cd-gpios to use &portb

v3 diff(s): Thanks to Doug Anderson, the real issue was that the GPIO bank used
by cd-gpios did not have status="okay" in the node. This cause the GPIO to not
get probed correctly.

In fact, prior to patch 3cf890fc42b "mmc: dw_mmc: Pass back errors from
mmc_of_parse()", the error was being masked, so it was not being detected.

v2 diff(s): Patch 2/2 ARM: dts: socfpga: Add a 3.3V fixed regulator node
        - Move the regulator nodes to their respective board dts file and
          correctly rename the regulator to match the schematic

Dinh Nguyen (3):
  ARM: dts: socfpga: rename gpio nodes
  ARM: dts: socfpga: Fix SD card detect
  ARM: dts: socfpga: Add a 3.3V fixed regulator node

 arch/arm/boot/dts/socfpga.dtsi                | 12 ++++++------
 arch/arm/boot/dts/socfpga_arria5.dtsi         |  2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    | 12 ++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  | 15 ++++++++++++++-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 12 ++++++++++++
 5 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.0.3
