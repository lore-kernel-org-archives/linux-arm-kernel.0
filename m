From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Jun 2012 21:45:19 +0800
Subject: [PATCH v2 0/5] fec driver updates
Message-ID: <1340804724-29410-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Add one patch to use devm_gpio_request_one
* Have a separate patch to fix phy-reset-gpios property in binding
  document
* Change phy-reset-interval to phy-reset-duration
* Add a sanity check on phy-reset-duration value

Shawn Guo (5):
  net: fec: reset phy after pinctrl setup
  net: fec: enable regulator for fec phy
  net: fec: use managed function devm_gpio_request_one
  net: fec: phy-reset-gpios is optional
  net: fec: add phy-reset-duration for device tree probe

 Documentation/devicetree/bindings/net/fsl-fec.txt |    6 +++-
 drivers/net/ethernet/freescale/fec.c              |   28 ++++++++++++++++++---
 2 files changed, 29 insertions(+), 5 deletions(-)

-- 
1.7.5.4
