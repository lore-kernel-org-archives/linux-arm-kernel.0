From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jan 2014 17:02:28 +0900
Subject: [PATCH v4 0/4] Add ethernet support for r7s72100
Message-ID: <1389168152-9434-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds ethernet support to sh-pfc for the r7s72100 SoC.

This series is based on a merge of:
* The topic/r7s72100-v3.13-rc7-20140107 tag in my renesas tree
* net-next
  - Head revision: 80077935cad223b29
    ("Merge branch 'master' of
      git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-next")

The first two patches, targeted at net-next, also applies cleanly there.

Changes since v3
* Use bool as return type of sh_eth_is_gether()
  and sh_eth_is_rz_fast_ether()
* Correct coding style in sh_eth_get_stats()

Changes since v2
* Trivial rebase
* Dropped "RFC" from subject

Changes since v1 are noted in the changelog of each patch.

Simon Horman (4):
  sh_eth: Use bool as return type of sh_eth_is_gether()
  sh_eth: Add support for r7s72100
  ARM: shmobile: r7s72100: Add clock for r7s72100-ether
  ARM: shmobile: genmai: Enable r7s72100-ether

 arch/arm/mach-shmobile/board-genmai.c   |  21 ++++++
 arch/arm/mach-shmobile/clock-r7s72100.c |   4 ++
 drivers/net/ethernet/renesas/sh_eth.c   | 124 +++++++++++++++++++++++++++++---
 drivers/net/ethernet/renesas/sh_eth.h   |   4 +-
 4 files changed, 143 insertions(+), 10 deletions(-)

-- 
1.8.4
