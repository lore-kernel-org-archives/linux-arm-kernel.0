From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  2 Dec 2011 11:52:55 +0200
Subject: [PATCH 0/5] ASoC: OMAP4: Device tree support for DMIC, McPDM
Message-ID: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following series adds device tree support for omap-dmic, omap-mcpdm ASoC
DAI drivers.

The OMAP4 platform patches have dependency on the DMIC driver series:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg59161.html

Regards,
Peter
---
Peter Ujfalusi (5):
  ASoC: omap-dmic: Add device tree bindings
  ASoC: omap-mcpdm: Add device tree bindings
  OMAP4: devices: Do not create dmic device if the dtb has been
    provided
  OMAP4: devices: Do not create mcpdm device if the dtb has been
    provided
  ARM: OMAP4: DTS: Support for dmic, and McPDM in device tree

 .../bindings/sound/soc/omap/omap-dmic.txt          |   13 +++++++++++++
 .../bindings/sound/soc/omap/omap-mcpdm.txt         |   13 +++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |    4 ++++
 arch/arm/boot/dts/omap4.dtsi                       |    9 +++++++++
 arch/arm/mach-omap2/devices.c                      |    8 ++++++++
 sound/soc/omap/omap-dmic.c                         |    8 ++++++++
 sound/soc/omap/omap-mcpdm.c                        |    8 ++++++++
 7 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/soc/omap/omap-dmic.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt

-- 
1.7.8.rc4
