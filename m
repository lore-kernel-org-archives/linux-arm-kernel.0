From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon,  7 Aug 2017 11:50:39 +0200
Subject: [PATCH 0/5] constify sdhci_pltfm_data and sdhci_ops structures
Message-ID: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci_pltfm_data structures are only passed as the second
argument of sdhci_pltfm_init, which is const, while the sdhci_ops
structures are only stored in the ops field of a sdhci_pltfm_data
structure, which is also const.  Thus both kinds of structures can
be const as well.

Done with the help of Coccinelle.

---

 drivers/mmc/host/sdhci-bcm-kona.c  |    4 ++--
 drivers/mmc/host/sdhci-brcmstb.c   |    2 +-
 drivers/mmc/host/sdhci-of-arasan.c |    4 ++--
 drivers/mmc/host/sdhci-pic32.c     |    2 +-
 drivers/mmc/host/sdhci-pxav3.c     |    2 +-
 drivers/mmc/host/sdhci-sirf.c      |    4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)
