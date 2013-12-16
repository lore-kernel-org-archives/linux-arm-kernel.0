From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 16 Dec 2013 16:46:35 -0500
Subject: [GIT PULL 1/3] ARM: keystone: device tree updates for 3.14
Message-ID: <1387230397-14338-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Please pull below keystone device tree updates for 3.14

Regards,
Santosh

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts

for you to fetch changes up to 732079567da4942b7b4929deff8f236926d0b3eb:

  ARM: dts: keystone: Add usb devicetree bindings (2013-12-12 20:29:17 -0500)

----------------------------------------------------------------
Keystone DTS updates for 3.14

- ddr3 pll clock node typo fixup.
- EVM specific clock setting with board k2hk-evm.dts.
- GIC node updates for missing virtualisation info.
- Adding USB dwc3 and phy nodes.

----------------------------------------------------------------
Murali Karicheri (3):
      ARM: keystone: dts: add a k2hk-evm specific dts file
      ARM: keystone: dts: fix typo in the ddr3 pllclk node name
      ARM: keystone: dts: add paclk divider clock node

Santosh Shilimkar (2):
      ARM: dts: keystone: Add the GICV and GICH address space
      ARM: dts: keystone: Add guestos maintenance interrupt

WingMan Kwok (2):
      ARM: dts: keystone: Add usb phy devicetree bindings
      ARM: dts: keystone: Add usb devicetree bindings

 .../devicetree/bindings/usb/keystone-phy.txt       |   20 +++++++
 .../devicetree/bindings/usb/keystone-usb.txt       |   42 +++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts                     |   63 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-clocks.dtsi             |   36 ++++++-----
 arch/arm/boot/dts/{keystone.dts => keystone.dtsi}  |   35 ++++++++++-
 5 files changed, 174 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
 create mode 100644 arch/arm/boot/dts/k2hk-evm.dts
 rename arch/arm/boot/dts/{keystone.dts => keystone.dtsi} (82%)
