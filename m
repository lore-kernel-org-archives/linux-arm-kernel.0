From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 18:46:00 +0100
Subject: [GIT PULL] Allwinner clocks changes for 3.20
Message-ID: <20150125174600.GA28225@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Here are the clock changes for the Allwinner platform for the 3.20
merge window.

Thanks,
Maxime

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-3.20

for you to fetch changes up to 76820fcf7aa5a418b69cb7bed31b62d1feb1d6ad:

  sunxi: clk: Set sun6i-pll1 n_start = 1 (2015-01-25 16:55:25 +0100)

----------------------------------------------------------------
Allwinner clock changes for 3.20

The set of clock changes for the 3.20 merge window, with mostly:
  - Some PLL fixes for the A80 and A31
  - The MMC custom phase functions are removed, and moved over to the generic
    phase API.
  - Add the A80 MMC clocks

Some DT changes slipped here as well, to preserve bisectability.

----------------------------------------------------------------
Chen-Yu Tsai (10):
      clk: sunxi: Remove ahb1_sdram from sun6i/sun8i protected clocks list
      clk: sunxi: unify sun6i AHB1 clock with proper PLL6 pre-divider
      ARM: dts: sun6i: Unify ahb1 clock nodes
      ARM: dts: sun8i: Unify ahb1 clock nodes
      ARM: dts: sun8i: Add PLL6 and MBUS clock nodes
      clk: sunxi: Fix factor clocks usage for sun9i core clocks
      clk: sunxi: Propagate rate changes to parent for mux clocks
      clk: sunxi: Add a common setup function for mmc module clocks
      clk: sunxi: Add mod0 and mmc module clock support for A80
      clk: sunxi: Add driver for A80 MMC config clocks/resets

Hans de Goede (4):
      clk: sunxi: Give sunxi_factors_register a registers parameter
      clk: sunxi: Make the mod0 clk driver also a platform driver
      clk: sunxi: rewrite sun9i_a80_get_pll4_factors()
      sunxi: clk: Set sun6i-pll1 n_start = 1

Maxime Ripard (4):
      clk: sunxi: Rework MMC phase clocks
      ARM: sunxi: dt: Add sample and output mmc clocks
      mmc: sunxi: Convert MMC driver to the standard clock phase API
      clk: sunxi: Remove custom phase function

 Documentation/devicetree/bindings/clock/sunxi.txt  |  43 +++-
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   8 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  72 ++++--
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  54 +++--
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  44 ++--
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  86 ++++---
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  72 ++++--
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  96 +++++---
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-factors.c                    |  10 +-
 drivers/clk/sunxi/clk-factors.h                    |   7 +-
 drivers/clk/sunxi/clk-mod0.c                       | 224 +++++++++++++-----
 drivers/clk/sunxi/clk-sun8i-mbus.c                 |  13 +-
 drivers/clk/sunxi/clk-sun9i-core.c                 | 119 +++++++---
 drivers/clk/sunxi/clk-sun9i-mmc.c                  | 219 +++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                      | 260 +++++++++++++++++----
 drivers/mmc/host/sunxi-mmc.c                       |  73 ++++--
 include/linux/clk/sunxi.h                          |  22 --
 18 files changed, 1092 insertions(+), 331 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-mmc.c
 delete mode 100644 include/linux/clk/sunxi.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/75f0a09a/attachment.sig>
