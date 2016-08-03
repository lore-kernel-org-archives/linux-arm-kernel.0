From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  3 Aug 2016 14:38:55 -0400
Subject: [PATCH 00/11] ARM: dts: NSP: define SATA, Reboot,
 RAM and new device tree files
Message-ID: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds SATA and RAM for the existing HR and XMC device
tree files (as they were missed when those peices were originally
added).  It also adds GPIO rebooting to the platforms that support that
feature.  Finally, add device tree files for all known NSP based
reference boards.

The only outstanding HW that isn't fully supported on all NSP boards is
USB and sound.  So, we're getting close :)

NOTE: SATA is not in the NSP DTSI in Florian's git tree, but it is
currently in Linus' (due to it going through another maintainer).  So,
it won't build until the merge with Linus' tree is done.  I thought it
better to do it this way instead of splitting it off and sending it as
a follow-on in a couple of weeks.  Let me know if it is preferred I do
it that way.

Thanks,
Jon

Jon Mason (11):
  ARM: dts: NSP: Enable SATA on bcm958625hr
  ARM: dts: NSP: Enable SATA and add i2c devices on XMC
  ARM: dts: NSP: Specify RAM amount for BCM958625K board
  ARM: dts: NSP: Specify RAM amount for BCM958525XMC board
  ARM: dts: NSP: Add GPIO reboot method to bcm958625hr DTS file
  ARM: dts: NSP: Add GPIO reboot method to bcm958625xmc DTS file
  ARM: dts: NSP: Add new DT file for bcm958525er
  ARM: dts: NSP: Add new DT file for bcm958522er
  ARM: dts: NSP: Add new DT file for bcm988312hr
  ARM: dts: NSP: Add new DT file for bcm958623hr
  ARM: dts: NSP: Add new DT file for bcm958622hr

 arch/arm/boot/dts/Makefile         |   5 +
 arch/arm/boot/dts/bcm958522er.dts  | 130 ++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958525er.dts  | 142 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958525xmc.dts |  44 ++++++++-
 arch/arm/boot/dts/bcm958622hr.dts  | 170 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958623hr.dts  | 178 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958625hr.dts  |  19 ++++
 arch/arm/boot/dts/bcm958625k.dts   |   5 +
 arch/arm/boot/dts/bcm988312hr.dts  | 182 +++++++++++++++++++++++++++++++++++++
 9 files changed, 874 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm958522er.dts
 create mode 100644 arch/arm/boot/dts/bcm958525er.dts
 create mode 100644 arch/arm/boot/dts/bcm958622hr.dts
 create mode 100644 arch/arm/boot/dts/bcm958623hr.dts
 create mode 100644 arch/arm/boot/dts/bcm988312hr.dts

-- 
2.7.4
