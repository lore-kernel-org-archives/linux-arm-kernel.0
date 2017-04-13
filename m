From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Apr 2017 11:59:38 +0200
Subject: [GIT PULL] Allwinner clock fixes for 4.11, again
Message-ID: <20170413095938.ac4zjp7ql6y76sst@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is another PR, without the patches that you didn't want as fixes.

A few more fixes showed up in between, one of them being another build
fix, the other one fixing random CPU crashes happening with CPUfreq
since 4.11

Please merge it for one of 4.11-rc's, thanks!
Maxime

The following changes since commit b467e08a15563dede0d37d3233baa24fb97a7310:

  clk: sunxi-ng: fix recalc_rate formula of NKMP clocks (2017-03-20 10:34:05 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi-clk-fixes-for-4.11-2-bis

for you to fetch changes up to 372fa10172a2f9e1bfbc70778449628e82b72341:

  clk: sunxi-ng: a33: gate then ungate PLL CPU clk after rate change (2017-04-13 11:22:04 +0200)

----------------------------------------------------------------
Allwinner clock fixes for 4.11

Two build errors fixes for the sunxi-ng drivers.

The two other patches fix random CPU crashes happening on the A33 since
CPUFreq has been enabled in 4.11.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks
      clk: sunxi-ng: a33: gate then ungate PLL CPU clk after rate change

Tobias Regnery (2):
      clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
      clk: sunxi-ng: fix build failure in ccu-sun9i-a80 driver

 drivers/clk/sunxi-ng/Kconfig         |  2 ++
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 11 ++++++++
 drivers/clk/sunxi-ng/ccu_common.c    | 49 ++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_common.h    | 12 +++++++++
 4 files changed, 74 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170413/97cfe53c/attachment.sig>
