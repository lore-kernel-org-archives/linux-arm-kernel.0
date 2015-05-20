From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 20 May 2015 20:03:05 +0200
Subject: [PATCH net-next 0/4] stmmac: probe code refactoring and clean up part
 1
Message-ID: <1432144989-28283-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set refactor the code in stmmac_pci_probe and stmmac_pltfr_probe
and moves the common bits into stmmac_dvr_probe. Along the way some clean-
ups are applied to stmmac_pltfr_probe.

The code has been tested on the LPC18xx platform.

I am still working on more refactoring of the platform probe code, hence
part 1, but I need some more time on this.


Joachim Eastwood (4):
  stmmac: move driver data setting into stmmac_dvr_probe
  stmmac: let stmmac_dvr_probe take a struct of resources
  stmmac: change the stmmac_dvr_probe return type to int
  stmmac: drop unnecessary dt checks in stmmac_probe_config_dt

 drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 14 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 30 +++++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 19 +++----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 62 +++++++---------------
 4 files changed, 54 insertions(+), 71 deletions(-)

-- 
1.8.0
