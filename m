From: embed3d@gmail.com (Philipp Rossak)
Date: Sat, 16 Dec 2017 03:49:09 +0100
Subject: [RFC 0/5] IR support for A83T - sunxi-ir driver update
Message-ID: <20171216024914.7550-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the sunxi A83T ir module and enhances the sunxi-ir driver.
Right now the base clock frequency for the ir driver is a hard coded define and is set to 8 MHz.
This works for the most common ir receivers. On the Sinovoip Bananapi M3 the ir receiver needs,
a 3 MHz base clock frequency to work without problems with this driver (like in the legacy kernel).

To fix this issue I reworked the driver that this value could be set over the devicetree.

About 37 devices would have a devicetree change if this patch series would be applied.
Therfore I would like to ask you to give me some feedback about the patch series, before I finialize it.


Thanks in advance!

Philipp


Philipp Rossak (5):
  [media] rc: update sunxi-ir driver to get base frequency from
    devicetree
  [media] dt: bindings: Update binding documentation for sunxi IR
    controller
  ARM: dts: sun8i: a83t: Add the ir pin for the A83T
  ARM: dts: sun8i: a83t: Add support for the ir interface
  ARM: dts: sun8i: a83t: bananapi-m3: Enable IR controller

 Documentation/devicetree/bindings/media/sunxi-ir.txt | 14 ++++++++------
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts         |  7 +++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                    | 15 +++++++++++++++
 drivers/media/rc/sunxi-cir.c                         | 20 +++++++++++---------
 4 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.11.0
