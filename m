From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Wed, 03 Dec 2014 16:38:36 +0000
Subject: [PATCH 0/5] ASoC: dwc: Add device tree support to designware I2S
Message-ID: <547F3C8C.5000607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set extends the DesignWare I2S driver to provide device
tree support and fixes a couple of small faults.

Andrew Jackson (5):
  ASoC: dwc: Allocate resources with devm_ioremap_resource
  ASoC: dwc: Don't allow negative use counts
  ASoC: dwc: Iterate over all channels
  ASoC: dwc: Add devicetree support for Designware I2S
  ASoC: dwc: Ensure FIFOs are flushed to prevent channel swap

 .../devicetree/bindings/sound/designware-i2s.txt   |   32 ++
 sound/soc/dwc/Kconfig                              |    1 +
 sound/soc/dwc/designware_i2s.c                     |  313 ++++++++++++++------
 3 files changed, 260 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
