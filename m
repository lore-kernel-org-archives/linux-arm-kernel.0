From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2012 18:32:20 +0100
Subject: [GIT PULL] Marvell: late fixes for 3.8
Message-ID: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Here is a set of five fixes for Marvell SoC support, for 3.8. If they
go in -rc1, it's good, but if it's too late, they can also just as
well go after -rc1 since they really are fixes.

 * PATCH 1 fixes an address decoding problem, which was preventing
   SMP from working on OpenBlocks AX3-4. It is quite important as with
   this patch, SMP simply doesn't work on OpenBlocks.

 * PATCH 2 fixes a XOR initialization problem, which so far has been
   seen only on OpenBlocks AX3-4 with its 2 GB memory extension, but
   it basically prevents the kernel from booting at all on this
   platform. So quite important fix.

 * PATCH 3, 4, 5 are fixes for error handling. So in the normal case,
   you don't get into the troubles that those patches are
   fixing... but when PATCH 2 wasn't here on OpenBlocks, it showed
   that the error handling of the mv_xor driver was not entirely
   correct.

If you want me to respin this with two separate pull requests, one for
the address decoding thing and the other one for the four mv_xor
fixes, just let me know and I'll do that.

Thanks!

The following changes since commit 1112b36094e48f89ce7dca5aee90b05c30162da9:

  Merge tag 'marvell-armadaxp-smp-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public into mevbu-dt-additions (2012-11-22 10:55:09 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git mvebu-misc-fixes

for you to fetch changes up to 73d9cdca1ced6ab32be363b58699039bd82b062a:

  dma: mv_xor: fix error handling path (2012-11-22 18:22:59 +0100)

----------------------------------------------------------------
Marvell misc fixes for 3.8

----------------------------------------------------------------
Thomas Petazzoni (5):
      arm: mvebu: fix address decoding armada_cfg_base() function
      dma: mv_xor: clear the window override control registers
      dma: mv_xor: use request_irq() instead of devm_request_irq()
      dma: mv_xor: fix error checking of irq_of_parse_and_map()
      dma: mv_xor: fix error handling path

 arch/arm/mach-mvebu/addr-map.c |    2 +-
 drivers/dma/mv_xor.c           |   18 +++++++++++-------
 drivers/dma/mv_xor.h           |    1 +
 3 files changed, 13 insertions(+), 8 deletions(-)
