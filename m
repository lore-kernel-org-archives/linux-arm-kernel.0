From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon,  5 Mar 2018 11:04:28 +0100
Subject: [PATCH 0/4] media: sun6i: Add support for the H3 CSI controller
Message-ID: <20180305100432.15009-1-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The H3 and H5 have a CSI controller based on the one previously found
in the A31, that is currently supported by the sun6i-csi driver.

Add the compatibles to the device tree bindings and to the driver to
make it work properly.

This obviously depends on the serie "Initial Allwinner V3s CSI
Support" by Yong Deng.

Let me know what you think,
Maxime

Maxime Ripard (2):
  dt-bindings: media: sun6i: Add A31 and H3 compatibles
  media: sun6i: Add A31 compatible

Myl?ne Josserand (2):
  ARM: dts: sun8i: Add the H3/H5 CSI controller
  [DO NOT MERGE] ARM: dts: sun8i: Add CAM500B camera module to the Nano
    Pi M1+

 .../devicetree/bindings/media/sun6i-csi.txt        |  5 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      | 85 ++++++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 22 ++++++
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |  1 +
 4 files changed, 112 insertions(+), 1 deletion(-)

-- 
2.14.3
