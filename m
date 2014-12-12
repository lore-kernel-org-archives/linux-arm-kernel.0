From: andrew.jackson@arm.com (Andrew Jackson)
Date: Fri, 12 Dec 2014 09:24:59 +0000
Subject: [PATCH v2 0/6] ASoC: dwc: Add device tree support to designware I2S
Message-ID: <cover.1418372910.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

This patch set extends the DesignWare I2S driver to provide device
tree support and fixes a couple of small faults.

Changes v1->v2
  + Drop negative use count patch [Mark Brown]
  + Remove unnecessary debug print messages [Lars-Peter Clausen]
  + Rewrite iteration as for loop rather than do...while [Mark Brown]
  + Reorder patches to send fixes first [Mark Brown]
  + Simplify device tree code [Mark Brown]
  + Split device tree patch in two [Mark Brown]
  + Expand explanatory comment on channel configuration [Rajeev Kumar]

Arnd: I've not forgotten about updating the spear entries

Andrew Jackson (6):
  ASoC: dwc: Remove unnecessary debug messages and tests
  ASoC: dwc: Ensure FIFOs are flushed to prevent channel swap
  ASoC: dwc: Iterate over all channels
  ASoC: dwc: Reorder code in preparation for DT support
  ASoC: dwc: Add devicetree support for Designware I2S
  ASoC: dwc: Add documentation for I2S DT

 .../devicetree/bindings/sound/designware-i2s.txt   |   32 +++
 sound/soc/dwc/Kconfig                              |    1 +
 sound/soc/dwc/designware_i2s.c                     |  294 ++++++++++++++------
 3 files changed, 248 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
