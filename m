From: frank.wang@rock-chips.com (Frank Wang)
Date: Fri, 11 Aug 2017 16:07:46 +0800
Subject: [PATCH v4 0/5] add some properties for Rockchip usb2-phy and add
 rv1108 SoCs' support
Message-ID: <1502438871-9482-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series of patches add rockchip,usbgrf property and otg_mux interrupt for
rockchip usb2-phy. In addition, this change also add rv1108 usb2-phy support.

Changes from v3:
 - Updated the 'Acked-by' tag from Rob Herring <robh@kernel.org>.
 - Matched the SoC specific compatible string instead of companion_grf_quirk.

Changes from v2:
 - Amend otg-mux interrupt to be auto-detectable and update related dt-bindings.

Changes from v1:
 - Send the dt-bindings as a separate patch and cc devicetree list.

Frank Wang (5):
  phy: rockchip-inno-usb2: add support for rockchip,usbgrf property
  dt-bindings: phy-rockchip-inno-usb2: add rockchip,usbgrf property
  phy: rockchip-inno-usb2: add support for otg-mux interrupt
  dt-bindings: phy-rockchip-inno-usb2: add otg-mux interrupt
  phy: rockchip-inno-usb2: add support of usb2-phy for rv1108 SoCs

 .../bindings/phy/phy-rockchip-inno-usb2.txt        |  11 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      | 215 ++++++++++++++++-----
 2 files changed, 174 insertions(+), 52 deletions(-)

-- 
2.0.0
