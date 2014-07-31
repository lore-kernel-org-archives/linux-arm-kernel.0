From: kever.yang@gmail.com (Kever Yang)
Date: Wed, 30 Jul 2014 21:29:55 -0700
Subject: [PATCH v2 0/4] Patches to add support for Rockchip dwc2 controller
Message-ID: <1406780999-17798-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kever Yang <kever.yang@gmail.com>

These patches to add support for dwc2 controller found in
Rockchip processors rk3066, rk3188 and rk3288,
and enable dts for rk3288 evb.

Changes in v2:
- Split out dr_mode and rk3288 bindings.
- add compatible "snps,dwc2" bingding info
- set most parameters as driver auto-detect
- change the node name from 'dwc2' to 'usb'
- evb patch added in version 2

Kever Yang (4):
  Documentation: dt-bindings: add dt binding info for Rockchip dwc2
  usb: dwc2: add compatible data for rockchip soc
  ARM: dts: add rk3288 dwc2 controller support
  ARM: dts: Enable USB otg and host1(dwc) on rk3288-evb

 Documentation/devicetree/bindings/usb/dwc2.txt |    3 +++
 arch/arm/boot/dts/rk3288-evb.dtsi              |    6 +++++
 arch/arm/boot/dts/rk3288.dtsi                  |   20 ++++++++++++++++
 drivers/usb/dwc2/platform.c                    |   29 ++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

-- 
1.7.9.5
