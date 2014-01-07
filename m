From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 11:27:12 +0900
Subject: [PATCH v3 0/3] Add ethernet support for r7s72100
Message-ID: <1389061635-4083-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a third pass at adding ethernet support to sh-pfc for
the r7s72100 SoC.

This series is based on a merge of:
* The topic/r7s72100-v3.13-rc7-20140107 tag in my renesas tree
* net-next
  - Head revision: 56a4342dfe3145cd
    ("Merge branch 'master' of
      git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")

The first patch, targeted at net-next, also applies cleanly there.

Changes since v2
* Trivial rebase
* Dropped "RFC" from subject

Changes since v1 are noted in the changelog of each patch.

Simon Horman (3):
  sh_eth: Add support for r7s72100
  ARM: shmobile: r7s72100: Add clock for r7s72100-ether
  ARM: shmobile: genmai: Enable r7s72100-ether

 arch/arm/mach-shmobile/board-genmai.c   |  21 ++++++
 arch/arm/mach-shmobile/clock-r7s72100.c |   4 ++
 drivers/net/ethernet/renesas/sh_eth.c   | 119 ++++++++++++++++++++++++++++++--
 drivers/net/ethernet/renesas/sh_eth.h   |   4 +-
 4 files changed, 141 insertions(+), 7 deletions(-)

-- 
1.8.4
