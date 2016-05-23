From: peppe.cavallaro@st.com (Giuseppe Cavallaro)
Date: Mon, 23 May 2016 15:17:41 +0200
Subject: [PATCH 0/2 (linux-stable-4.5.y)] net: stmmac: MDIO fixes
Message-ID: <1464009463-23654-1-git-send-email-peppe.cavallaro@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches port some recent fixes for linux-4.5.y stable branch.
They fix the MDIO settings trying to cover the all possible scenario
when the stmmac is connected to a real transceiver or a switch.

These patches are needed for Kernel 4.5 where Lime2, BananaPi and Cubieboard2
show problems when use the stmmac:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823493

Additional Note:

 o The 4.4.y branch has a previous version of the stmmac;
   that is not including the development that introduced
   the regressions for MDIO bus.

 o The 4.5.y kernel has "March_2013" stmmac version plus the
   patch that introduce some MDIO configuration problems
   so the regressions.

 o The 4.6.y has all the fixes on top of the "Oct_2015"
   stmmac version.

Giuseppe CAVALLARO (1):
  Revert "stmmac: Fix 'eth0: No PHY found' regression"

Giuseppe Cavallaro (1):
  stmmac: fix MDIO settings

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 11 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 10 +--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 91 ++++++++++++++++------
 3 files changed, 70 insertions(+), 42 deletions(-)

-- 
2.7.4
