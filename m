From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:35 +0200
Subject: [PATCH 00/16] Orion DT conversions and fixes.
Message-ID: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a collection of patches converting more drivers used by orion
to DT. Then, where possible, convert platform code to use DT. Also
a few fixes are mixed in.

- IRQ/GPIO/SPI/WDT/SATA have all been seen before and no changes made.
- I2C has been split in two, with the driver parts now going via
  i2c-embedded/for-next
- gpio-key and gpio-led converted to DT equivalents.
- Ensure runit clock always ticks is a rework of an earlier patch, now
  including comments from Marvell engineers.
- Replace mrvl with marvell implements the decision made here:
  http://www.spinics.net/lists/arm-kernel/msg176524.html

These patches, plus the I2C driver change and all the patches i've
collected from others ready for submission to arm-soc/for-next can be
found in:

git://github.com/lunn/linux.git v3.5-rc7-for-next-v5 

Andrew Lunn (16):
  ARM: Orion: DT support for IRQ and GPIO Controllers
  SPI: Refactor spi-orion to use SPI framework queue.
  ARM: Kirkwood: Ensure runit clock always ticks.
  ARM: Orion: Add arch support needed for I2C via DT.
  Kirkwood: Add basic device tree support for QNAP TS219.
  ARM: Orion: DTify the watchdog timer.
  ATA: sata_mv: Add device tree support
  ARM: Kirkwood: Use DT to configure SATA device.
  ARM: Kirkwood: Describe DNS325 temperature sensor in DT.
  ARM: Kirkwood: Describe IB62x0 gpio-keys in DT.
  ARM: Kirkwood: Describe iConnects temperature sensor in DT.
  ARM: Kirkwood: Describe Dreamplug LEDs in DT.
  ARM: Kirkwood: Describe GoFlex Net LEDs and SATA in DT.
  ARM: Kirkwood: Describe ib62x0 LEDs in DT.
  ARM: Kirkwood: Describe iConnect LEDs in DT.
  ARM: Kirkwood: Replace mrvl with marvell
