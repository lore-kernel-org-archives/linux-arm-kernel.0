From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 16:15:40 +0800
Subject: [GIT PULL] Allwinner clock fixes for 4.13
Message-ID: <20170802081540.kzy2q7qo4lb3muxt@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

I will be handling most of the Allwinner pull requests for this cycle.
Here is a critical fix for the sunxi-ng clk drivers.

Thanks
ChenYu

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.13

for you to fetch changes up to 9735ee9e3cc3ba113ac96b0368ef3f1a73092a23:

  clk: sunxi-ng: sun5i: Add clk_set_rate_parent to the CPU clock (2017-07-24 11:37:04 +0200)

----------------------------------------------------------------
Allwinner clock fixes for 4.13

One critical clock fix for sun5i (A10s/A13/R8) which enables propogation
of clock rate changes from the "cpu" clock to it's parent PLL clock.
This fixes cpufreq related crashes that have been observed on KernelCI
with the C.H.I.P. and multi_v7_defconfig.

----------------------------------------------------------------
Maxime Ripard (1):
      clk: sunxi-ng: sun5i: Add clk_set_rate_parent to the CPU clock

 drivers/clk/sunxi-ng/ccu-sun5i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170802/704bd691/attachment.sig>
