From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 20 Dec 2013 16:51:15 +0100
Subject: [PATCH v2 0/2] ARM: omap3: Split the pinmux core device
Message-ID: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

While working on the OMAP3 ISP driver I've run into a failure to request a
memory region already requested by the pinctrl-single driver. This patch set
is an attempt to fix the problem.

Changes since v1:

- Rebased on top of Tony's master branch
- Handle IGEP LEDs
- Added Tony's PINCTRL macros
- Fixed unbalanced parentheses in Tony's PINCTRL macros ;-)

Laurent Pinchart (1):
  ARM: omap3: Split the pinmux core device

Tony Lindgren (1):
  ARM: dts: Add omap specific pinctrl defines to use padconf addresses

 arch/arm/boot/dts/omap3-beagle-xm.dts | 40 +++++++++++++++++----------
 arch/arm/boot/dts/omap3-beagle.dts    | 40 +++++++++++++++++----------
 arch/arm/boot/dts/omap3-igep.dtsi     |  2 --
 arch/arm/boot/dts/omap3-igep0020.dts  | 52 +++++++++++++++++++----------------
 arch/arm/boot/dts/omap3-igep0030.dts  | 10 ++++---
 arch/arm/boot/dts/omap3-zoom3.dts     | 23 ++++++++++------
 arch/arm/boot/dts/omap3.dtsi          | 13 ++++++++-
 include/dt-bindings/pinctrl/omap.h    | 19 +++++++++++++
 8 files changed, 133 insertions(+), 66 deletions(-)

-- 
Regards,

Laurent Pinchart
