From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:33 +0100
Subject: [PATCH 00/11] Fixes for 3.8-rc
Message-ID: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a collection of fixes for 3.8-rc for Marvell SoCs and
drivers.

If nobody objects, i will send Olof and Arnd a pull request sometime
Monday.

Andrew Lunn (5):
  ARM: Kirkwood: Fix missing clk for USB device.
  Power: gpio-poweroff: Fix documentation and gpio_is_valid
  ARM: Kirkwood: Fix missing sdio clock
  ARM: Kirkwood: Use fixed-regulator instead of board gpio call
  arm: mvebu: Add missing ; for cpu node.

Joshua Coombs (1):
  clk: mvebu: Remove inappropriate __init tagging

Nobuhiro Iwamatsu (1):
  ARM: Kirkwood: Switch TWSI1 of 88f6282 to DT clock providers

Thomas Petazzoni (4):
  arm: mvebu: Armada XP MV78230 has two cores, not one
  arm: mvebu: Armada XP MV78230 has only three Ethernet interfaces
  dma: mv_xor: fix error handling of mv_xor_channel_add()
  dma: mv_xor: fix error handling for clocks

 .../devicetree/bindings/gpio/gpio-poweroff.txt     |   20 ++++++++++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |    9 +++++-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |    8 +++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |    8 +++++
 arch/arm/boot/dts/armada-xp.dtsi                   |    8 -----
 arch/arm/boot/dts/kirkwood-6282.dtsi               |    1 +
 arch/arm/boot/dts/kirkwood-topkick.dts             |   17 ++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |    1 +
 arch/arm/mach-kirkwood/board-dt.c                  |    4 +++
 arch/arm/mach-kirkwood/board-usi_topkick.c         |    4 ---
 drivers/clk/mvebu/clk-gating-ctrl.c                |    2 +-
 drivers/dma/mv_xor.c                               |    9 ++++--
 drivers/power/reset/gpio-poweroff.c                |   33 +++++++++-----------
 13 files changed, 86 insertions(+), 38 deletions(-)

-- 
1.7.10.4
