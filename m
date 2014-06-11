From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Jun 2014 10:45:19 +0200
Subject: [GIT PULL] Allwinner sunXi clock changes for 3.16, rebased
Message-ID: <20140611084519.GA22486@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Like you asked on IRC, here is the clocks additions for the Allwinner
SoCs, rebased on your current clk-next.

Thanks,
Maxime

The following changes since commit 3f6eec9969d24f91a3909d51e86e007ca5efd4c4:

  Merge branch 'for-v3.16/ti-clk-drv' of github.com:t-kristo/linux-pm into clk-next (2014-06-10 16:53:25 -0700)

are available in the git repository at:


  https://github.com/mripard/linux.git tags/sunxi-clk-for-3.16-2

for you to fetch changes up to 5c89a8b65760a60eea38e0b172d04152ec03a067:

  clk: sunxi: document PRCM clock compatible strings (2014-06-11 10:25:03 +0200)

----------------------------------------------------------------
Rebase of Emilio's clk-sunxi-for-3.16 on top of clk-next

Fixed a few compilation warnings exposed by a patch introduced during the 3.16
merge window.

Original tag message:

Allwinner sunXi SoCs clock changes

This pull contains some new code to add support for A31 clocks by Maxime
and Boris. It also reworks the driver a bit to avoid having a huge
single file when we have a full folder for ourselves, and separating
different functional units makes sense.

----------------------------------------------------------------
Boris BREZILLON (2):
      clk: sunxi: add PRCM (Power/Reset/Clock Management) clks support
      clk: sunxi: document PRCM clock compatible strings

Emilio L?pez (1):
      clk: sunxi: document new A31 USB clock compatible

Maxime Ripard (7):
      clk: sunxi: Implement A31 USB clock
      clk: sunxi: Remove calls to clk_put
      clk: sunxi: Move the 24M oscillator to a file of its own
      clk: sunxi: Move the GMAC clock to a file of its own
      clk: sunxi: Rework clock protection code
      clk: sun6i: Protect CPU clock
      clk: sun6i: Protect SDRAM gating bit

 Documentation/devicetree/bindings/clock/sunxi.txt |   4 +
 drivers/clk/sunxi/Makefile                        |   4 +
 drivers/clk/sunxi/clk-a10-hosc.c                  |  73 +++++++
 drivers/clk/sunxi/clk-a20-gmac.c                  | 119 +++++++++++
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          |  99 +++++++++
 drivers/clk/sunxi/clk-sun6i-apb0.c                |  77 +++++++
 drivers/clk/sunxi/clk-sun6i-ar100.c               | 233 +++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                     | 239 +++++-----------------
 8 files changed, 661 insertions(+), 187 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-a10-hosc.c
 create mode 100644 drivers/clk/sunxi/clk-a20-gmac.c
 create mode 100644 drivers/clk/sunxi/clk-sun6i-apb0-gates.c
 create mode 100644 drivers/clk/sunxi/clk-sun6i-apb0.c
 create mode 100644 drivers/clk/sunxi/clk-sun6i-ar100.c

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140611/827e7e4f/attachment.sig>
