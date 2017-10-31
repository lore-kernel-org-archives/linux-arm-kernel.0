From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Tue, 31 Oct 2017 09:11:42 +0800
Subject: [PATCH v4 0/3] media: ov7740: Add a V4L2 sensor-level driver
Message-ID: <20171031011146.6899-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Video4Linux2 sensor-level driver for the OmniVision OV7740
VGA camera image sensor.

Changes in v4:
 - Assign 'val' a initial value to avoid warning: 'val' may be
   used uninitialized.
 - Rename REG_REG15 to avoid warning: "REG_REG15" redefined.

Changes in v3:
 - Explicitly document the "remote-endpoint" property.
 - Put the MAINTAINERS change to a separate patch.

Changes in v2:
 - Split off the bindings into a separate patch.
 - Add a new entry to the MAINTAINERS file.

Wenyou Yang (3):
  media: i2c: Add the ov7740 image sensor driver
  media: ov7740: Document device tree bindings
  MAINTAINERS: Add a new entry of the ov7740 driver

 .../devicetree/bindings/media/i2c/ov7740.txt       |   47 +
 MAINTAINERS                                        |    8 +
 drivers/media/i2c/Kconfig                          |    8 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/ov7740.c                         | 1220 ++++++++++++++++++++
 5 files changed, 1284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov7740.txt
 create mode 100644 drivers/media/i2c/ov7740.c

-- 
2.13.0
