From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Fri, 17 May 2013 15:35:42 +0200
Subject: [PATCH 0/2] Driver for Allwinner sunxi Security ID
Message-ID: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A-series of SoC's have efuses exposed via registers to read the
factory programmed e-fuses. These should in theory be programmable but this is
still to be confirmed. It does appear that these fuses are unique enough to be
used as serial numbers, RSA keys, generate MAC addresses from etc. If it turns
out to be user programmable, the use obviously increases. Allwinner did use the
fuses initially to determine the chip-type.

This driver supports all currently known chips based on datasheets and 'dumped'
drivers that we have so far, the dts is only implemented for known chips.

This is my very first driver so please try to be gentle ;)

Oliver Schinagl (2):
  Initial support for Allwinner's Security ID fuses
  Add sunxi-sid to dts for sun4i and sun5i

 arch/arm/boot/dts/sun4i-a10.dtsi |   5 +
 arch/arm/boot/dts/sun5i-a13.dtsi |   5 +
 drivers/misc/eeprom/Kconfig      |  19 ++++
 drivers/misc/eeprom/Makefile     |   1 +
 drivers/misc/eeprom/sunxi_sid.c  | 218 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 248 insertions(+)
 create mode 100644 drivers/misc/eeprom/sunxi_sid.c

-- 
1.8.1.5
