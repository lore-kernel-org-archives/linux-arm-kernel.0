From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:31:32 +0800
Subject: [PATCH 0/6] ARM: sunxi: Enable AXP PMIC power supplies
Message-ID: <20170525073138.20907-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series enables the power supplies for the AXP PMICs on boards
that I currently have and am actively testing.

The first patch re-orders the node references for the Cubieboard 2
dts, to maintain alphabetical order.

Patches 2 through 5 enable the ACIN power supply on various boards.

Patch 6 ties the USB/VBUS power supply of the PMIC to the USB PHY.
The PHY should have all available methods of VBUS detection configured.
The Cubietruck already has the power supplies enabled, but the USB
power supply was not configured to be used for VBUS detection.

Regards
ChenYu


Chen-Yu Tsai (6):
  ARM: sun7i: a20: cubieboard2: Move usb_otg node for alphabetical
    ordering
  ARM: sun7i: a20: cubieboard2: Enable AXP209's ACIN power supply
  ARM: sun7i: a20: bananapi-m1-plus: Enable AXP209's ACIN power supply
  ARM: sun4i: a10: cubieboard: Enable AXP209's ACIN power supply
  ARM: sun6i: a31: hummingbird: Enable AXP221's ACIN power supply
  ARM: sun7i: a20: cubietruck: Tie AXP209's USB power supply to USB PHY

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  4 ++++
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      |  4 ++++
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts |  4 ++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 12 ++++++++----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |  1 +
 5 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.11.0
