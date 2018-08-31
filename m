From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Fri, 31 Aug 2018 20:14:34 +0300
Subject: [PATCH v2 0/2] Add support for MikroElektronika PROTO codec
Message-ID: <20180831171436.13360-1-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on Florian's initial PROTO driver:
https://lkml.org/lkml/2013/5/22/342

My changes made the driver more generic, so that we could connect other
I2S CPU DAIs, by using device-tree.

Tested with sama5d2 I2S driver.

Changes in v2:
 - removed unnecessary code that added constraints for the fixed SYSLK;
 - fixed errors reported by kbuild;	
 - adjusted "mikroe" in vendor prefixes;
 - updated description in Kconfig;

Codrin Ciubotariu (2):
  ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
  ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board

 .../bindings/sound/mikroe,mikroe-proto.txt    |  23 +++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 sound/soc/atmel/Kconfig                       |  11 ++
 sound/soc/atmel/Makefile                      |   2 +
 sound/soc/atmel/mikroe-proto.c                | 165 ++++++++++++++++++
 5 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
 create mode 100644 sound/soc/atmel/mikroe-proto.c

-- 
2.17.1
