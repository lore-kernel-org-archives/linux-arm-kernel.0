From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 Feb 2018 19:31:20 +0800
Subject: [GIT PULL] Allwinner clock fixes for 4.16
Message-ID: <20180223113120.GA2659@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-fixes-for-4.16

for you to fetch changes up to 5682e268350f9eccdbb04006605c1b7068a7b323:

  clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops (2018-02-19 08:59:50 +0100)

----------------------------------------------------------------
Allwinner clock fixes for 4.16

A critical fix for the A31 sunxi-ng clock driver. The CLK_OUT clocks
had definitions paired with the incorrect type of clk ops. This results
in a serious oops starting with commit 946797aa3f08 ("clk: sunxi-ng:
Support fixed post-dividers on MP style clocks"), which exposed the
incorrect clk ops when it added a new field to the data structures,
which then nudged the underlying (compatible but incorrect) data
structures out of alignment.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180223/23efdda1/attachment.sig>
