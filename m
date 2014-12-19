From: andrew.jackson@arm.com (Andrew Jackson)
Date: Fri, 19 Dec 2014 16:18:04 +0000
Subject: [PATCH v3 0/5] ASoC: dwc: Add device tree support to designware I2S
Message-ID: <cover.1418826016.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

This patch set extends the DesignWare I2S driver to provide device
tree support and fixes a couple of small faults.

Changes v2->v3
  + Drop applied patch
  + Flush FIFOs in prepare rather than hw_params [Lars-Peter Clausen]

Changes v1->v2
  + Drop negative use count patch [Mark Brown]
  + Remove unnecessary debug print messages [Lars-Peter Clausen]
  + Rewrite iteration as for loop rather than do...while [Mark Brown]
  + Reorder patches to send fixes first [Mark Brown]
  + Simplify device tree code [Mark Brown]
  + Split device tree patch in two [Mark Brown]
  + Expand explanatory comment on channel configuration [Rajeev Kumar]

Arnd: I've not forgotten about updating the spear entries and
      will submit as a separate patch.

Andrew Jackson (5):
  ASoC: dwc: Ensure FIFOs are flushed to prevent channel swap
  ASoC: dwc: Iterate over all channels
  ASoC: dwc: Reorder code in preparation for DT support
  ASoC: dwc: Add devicetree support for Designware I2S
  ASoC: dwc: Add documentation for I2S DT

 .../devicetree/bindings/sound/designware-i2s.txt   |   32 +++
 sound/soc/dwc/Kconfig                              |    1 +
 sound/soc/dwc/designware_i2s.c                     |  293 +++++++++++++++-----
 3 files changed, 258 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
