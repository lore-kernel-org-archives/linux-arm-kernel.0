From: kever.yang@gmail.com (Kever Yang)
Date: Thu, 31 Jul 2014 13:51:41 -0700
Subject: [PATCH v3 0/5] Patches to add support for Rockchip dwc2 controller
Message-ID: <1406839906-14633-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches to add support for dwc2 controller found in
Rockchip processors rk3066, rk3188 and rk3288,
and enable dts for rk3288 evb.

Changes in v3:
- Moved out of pin control and sort by base address
- EHCI and HSIC move new for version 3.
- Rebase

Changes in v2:
- Split out dr_mode and rk3288 bindings.
- add compatible "snps,dwc2" bingding info
- set most parameters as driver auto-detect
- change the node name from 'dwc2' to 'usb'
- evb patch added in version 2

Doug Anderson (1):
  ARM: dts: Fix the sort ordering of EHCI and HSIC in rk3288.dtsi

Kever Yang (4):
  Documentation: dt-bindings: add dt binding info for Rockchip dwc2
  usb: dwc2: add compatible data for rockchip soc
  ARM: dts: add rk3288 dwc2 controller support
  ARM: dts: Enable USB otg and host1(dwc) on rk3288-evb

 Documentation/devicetree/bindings/usb/dwc2.txt |    3 ++
 arch/arm/boot/dts/rk3288-evb.dtsi              |    6 +++
 arch/arm/boot/dts/rk3288.dtsi                  |   61 ++++++++++++++++--------
 drivers/usb/dwc2/platform.c                    |   29 +++++++++++
 4 files changed, 78 insertions(+), 21 deletions(-)

-- 
1.7.9.5
