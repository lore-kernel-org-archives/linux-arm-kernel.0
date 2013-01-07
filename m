From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 16:37:25 +0000
Subject: [GIT PULL V2] ARM: mvebu/kirkwood fixes for v3.8
In-Reply-To: <E1TrutN-00017j-7o@merlin.infradead.org>
Message-ID: <mailman.20.1357576650.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.8

for you to fetch changes up to ba607b6238a1f418c45b9d7f73212bcc6922da53:

  pinctrl: mvebu: make pdma clock on dove mandatory (2013-01-07 16:19:02 +0000)

----------------------------------------------------------------
fixes for mvebu/kirkwood v3.8
 - use correct uart driver for mvebu boards
 - add a missing DT clocks
 - gpio-poweroff level vs. edge triggering, use gpio_is_valid()
 - remove an inappropriate __init, modules need to access function.
 - various DT fixes
 - error handling in mv_xor

----------------------------------------------------------------
Andrew Lunn (5):
      ARM: Kirkwood: Fix missing clk for USB device.
      Power: gpio-poweroff: Fix documentation and gpio_is_valid
      ARM: Kirkwood: Fix missing sdio clock
      ARM: Kirkwood: Use fixed-regulator instead of board gpio call
      arm: mvebu: Add missing ; for cpu node.

Gregory CLEMENT (1):
      arm: mvebu: Use dw-apb-uart instead of ns16650 as UART driver

Joshua Coombs (1):
      clk: mvebu: Remove inappropriate __init tagging

Nobuhiro Iwamatsu (1):
      ARM: Kirkwood: Switch TWSI1 of 88f6282 to DT clock providers

Sebastian Hesselbarth (2):
      ARM: Dove: Add pinctrl clock to DT
      pinctrl: mvebu: make pdma clock on dove mandatory

Thomas Petazzoni (4):
      arm: mvebu: Armada XP MV78230 has two cores, not one
      arm: mvebu: Armada XP MV78230 has only three Ethernet interfaces
      dma: mv_xor: fix error handling of mv_xor_channel_add()
      dma: mv_xor: fix error handling for clocks

 .../devicetree/bindings/gpio/gpio-poweroff.txt     | 20 +++++++++++--
 arch/arm/boot/dts/armada-370-xp.dtsi               |  6 ++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  9 +++++-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  8 ++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  8 ++++++
 arch/arm/boot/dts/armada-xp.dtsi                   | 14 +++------
 arch/arm/boot/dts/dove.dtsi                        |  1 +
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  1 +
 arch/arm/boot/dts/kirkwood-topkick.dts             | 17 +++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |  1 +
 arch/arm/configs/mvebu_defconfig                   |  4 +--
 arch/arm/mach-kirkwood/board-dt.c                  |  4 +++
 arch/arm/mach-kirkwood/board-usi_topkick.c         |  4 ---
 drivers/clk/mvebu/clk-gating-ctrl.c                |  2 +-
 drivers/dma/mv_xor.c                               |  9 ++++--
 drivers/pinctrl/mvebu/pinctrl-dove.c               |  7 +++--
 drivers/power/reset/gpio-poweroff.c                | 33 ++++++++++------------
 17 files changed, 101 insertions(+), 47 deletions(-)
