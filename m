From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 8 Jan 2018 11:49:01 +0800
Subject: [GIT PULL] Allwinner clock changes for 4.16, round 2
Message-ID: <20180108034901.GA5577@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here are a few more clock changes for 4.16. The DE2 clock changes have
been around for awhile. The A83T clock fix was found by Jernej while
working on HDMI output for the SoC. We'd like to get these in so patches
don't pile up on the mailing lists.

ChenYu

The following changes since commit e952ca3c6b2ffdfbf9618e4bd3e9aad1ff3f5eb4:

  clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL (2017-12-08 10:08:32 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.16-2

for you to fetch changes up to 7dbc7f5f4904cfddc199af171ea095490a434f15:

  clk: sunxi-ng: a83t: Add M divider to TCON1 clock (2018-01-03 13:45:04 +0800)

----------------------------------------------------------------
Allwinner clock changes for 4.16, part 2

The hardware description for the DE2 clocks on the A64 and H5 SoCs is
fixed, and support for these clocks on the H3 is added. Also, the
description for the TCON1 clock on the A83T is fixed. All these are
non-critical, as they have no users.

----------------------------------------------------------------
Icenowy Zheng (3):
      dt-bindings: fix the binding of Allwinner DE2 CCU of A83T and H3
      clk: sunxi-ng: add support for Allwinner H3 DE2 CCU
      clk: sunxi-ng: fix the A64/H5 clock description of DE2 CCU

Jernej ??krabec (1):
      clk: sunxi-ng: a83t: Add M divider to TCON1 clock

 .../devicetree/bindings/clock/sun8i-de2.txt        |  5 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |  4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               | 53 ++++++++++++++++++++--
 3 files changed, 55 insertions(+), 7 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180108/90dc81ce/attachment-0001.sig>
