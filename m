From: embed3d@gmail.com (Philipp Rossak)
Date: Sun, 17 Dec 2017 23:45:42 +0100
Subject: [PATCH 0/5] arm: sunxi: IR support for A83T
Message-ID: <20171217224547.21481-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the sunxi A83T ir module and enhances the sunxi-ir driver.
Right now the base clock frequency for the ir driver is a hard coded define and is set to 8 MHz.
This works for the most common ir receivers. On the Sinovoip Bananapi M3 the ir receiver needs,
a 3 MHz base clock frequency to work without problems with this driver.

This patch series adds support for an optinal property that makes it able to override the default
base clock frequency and enables the ir interface on the a83t and the Bananapi M3.

changes since rfc:
* The property is now optinal. If the property is not available in the dtb the driver 
  uses the default base clock frequency.
* the driver prints out the the selected base clock frequency.
* changed devicetree property from base-clk-frequency to clock-frequency

Regards,
Philipp

rfc: https://www.mail-archive.com/linux-media at vger.kernel.org/msg123359.html 

Philipp Rossak (5):
  media: rc: update sunxi-ir driver to get base clock frequency from
    devicetree
  media: dt: bindings: Update binding documentation for sunxi IR
    controller
  arm: dts: sun8i: a83t: Add the ir pin for the A83T
  arm: dts: sun8i: a83t: Add support for the ir interface
  arm: dts: sun8i: a83t: bananapi-m3: Enable IR controller

 Documentation/devicetree/bindings/media/sunxi-ir.txt |  2 ++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts         |  7 +++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                    | 15 +++++++++++++++
 drivers/media/rc/sunxi-cir.c                         | 20 ++++++++++++--------
 4 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.11.0
