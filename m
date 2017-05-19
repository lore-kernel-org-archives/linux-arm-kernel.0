From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:58:00 +0200
Subject: [PATCH 0/5] Improve ap806 clk support on Marvell Armada 7K/8K
Message-ID: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series modifies the device tree binding of the clock of the AP806
part that we find in the Marvell Armada 7K/8K SoCs.

As for the CP110, we want to be able to ease the integration of new
clocks without breaking the backward compatibility. It is done in
patch 2.

We also want to ease the integration of the pinctrl node in the device
tree. It is the purpose of the patch 3.

Here again the last two patches modify the device tree to take into
account theses changes. They must be merged through the mvebu tree to
avoid future conflict.

In this series (as in the previous one for CP110), even if there is
some change in the device tree binding we paid attention to the
backward compatibility, and the driver can still work with the old
device tree.

Thanks,

Gregory

Gregory CLEMENT (5):
  clk: mvebu: ap806: cosmetic improvement
  clk: mvebu: ap806: do not depend anymore of the *-clock-output-names
  clk: mvebu: ap806: introduce a new binding
  arm64: dts: marvell: remove clock-output-names on ap806
  arm64: dts: marvell: use new binding for the system controller on ap806

 Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt |  24 ++++++++++------
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                             |  23 +++++++--------
 drivers/clk/mvebu/ap806-system-controller.c                               | 107 +++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 3 files changed, 97 insertions(+), 57 deletions(-)

base-commit: 4139fcd6c66df1c3d3fa0a0a7cf7f8a8c601a16c
-- 
git-series 0.9.1
