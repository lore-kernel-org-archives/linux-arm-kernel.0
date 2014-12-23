From: andrew.jackson@arm.com (Andrew Jackson)
Date: Tue, 23 Dec 2014 13:56:22 +0000
Subject: [PATCH v4 0/5] ASoC: dwc: Add device tree support to designware I2S
Message-ID: <cover.1419342218.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

This patch set extends the DesignWare I2S driver to provide device
tree support and fixes a couple of small faults.

Changes v3->v4
  + Drop applied patches
  + Use combined function to prepare clock [Mark Brown]
  + Use managed clock resources to avoid clk_put [Mark Brown]
  + Read configuration prameters from hardware for both platform data
    and device tree [Mark Brown]
  + Re-order patch sequence [Mark Brown]
  + Change union name to avoid future collisions [Mark Brown]
  + Check return code from clk_set_rate [Mark Brown]
  + Check parametsrs read from hardware agaist array limits and
    add further comments [Mark Brown]
  + Add of_match_ptr [Mark Brown]

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
  ASoC: dwc: Prepare clock before use
  ASoC: dwc: Switch to managed clock resource
  ASoC: dwc: Read I2S block configuration from registers
  ASoC: dwc: Add documentation for I2S DT
  ASoC: dwc: Add devicetree support for Designware I2S

 .../devicetree/bindings/sound/designware-i2s.txt   |   31 +++
 sound/soc/dwc/Kconfig                              |    1 +
 sound/soc/dwc/designware_i2s.c                     |  275 ++++++++++++++++----
 3 files changed, 260 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
