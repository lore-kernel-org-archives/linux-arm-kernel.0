From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Dec 2017 16:25:24 +0800
Subject: [GIT PULL] Allwinner clock changes for 4.16
Message-ID: <20171228082524.GA13649@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.16

for you to fetch changes up to e952ca3c6b2ffdfbf9618e4bd3e9aad1ff3f5eb4:

  clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL (2017-12-08 10:08:32 +0100)

----------------------------------------------------------------
Allwinner clock changes for 4.16

Fixed-post-divider support is added for two types of our clocks.
This in turn is used to support odd clocks on some of our SoCs.
On the A64, the MMC module clocks have a hidden post-divider.
On the A83T, a post-divider is needed to support programming
sigma-delta modulation with known fixed parameters from the
BSP kernel for the audio PLL.

There's also a small cleanup to use the shorter PTR_ERR_OR_ZERO
macro in various functions.

----------------------------------------------------------------
Chen-Yu Tsai (5):
      clk: sunxi-ng: Support fixed post-dividers on MP style clocks
      clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module clocks
      clk: sunxi-ng: Support fixed post-dividers on NM style clocks
      clk: sunxi-ng: sun8i: a83t: Add /2 fixed post divider to audio PLL
      clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL

Vasyl Gomonovych (1):
      clk: sunxi: Use PTR_ERR_OR_ZERO()

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 57 +++++++++++++++++++++++------------
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 18 +++++++++--
 drivers/clk/sunxi-ng/ccu_mp.c         | 20 ++++++++++--
 drivers/clk/sunxi-ng/ccu_mp.h         | 24 +++++++++++++++
 drivers/clk/sunxi-ng/ccu_nm.c         | 50 ++++++++++++++++++++++--------
 drivers/clk/sunxi-ng/ccu_nm.h         |  2 ++
 drivers/clk/sunxi/clk-sun8i-apb0.c    |  5 +--
 7 files changed, 134 insertions(+), 42 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171228/6a97397e/attachment.sig>
