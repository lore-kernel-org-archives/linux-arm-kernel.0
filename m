From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  3 Aug 2017 10:44:12 +0900
Subject: [PATCH v2 0/4] mmc: sdhci: refactor PM in sdhci-pltfm add support PM
 for cadence port
Message-ID: <1501724656-12435-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[1] adds clk handling for suspend/resume hooks of sdhci-pltfm.
    This also cleans up sdhci-brcmstb.c and sdhci-sirf.c

[2] Drop unneeded #ifdef CONFIG_PM, which will be used by [4]

[3] exports suspend / resume, which will be used by [4]

[4] implements suspend / resume for sdhci-cadence.c



Masahiro Yamada (4):
  mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
  mmc: sdhci: remove #indef CONFIG_PM around function declarations
  mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume
  mmc: sdhci-cadence: add suspend / resume support

 drivers/mmc/host/sdhci-brcmstb.c | 37 +------------------
 drivers/mmc/host/sdhci-cadence.c | 77 +++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-pltfm.c   | 22 ++++++++++--
 drivers/mmc/host/sdhci-pltfm.h   |  2 ++
 drivers/mmc/host/sdhci-sirf.c    | 39 +-------------------
 drivers/mmc/host/sdhci.h         |  4 ---
 6 files changed, 91 insertions(+), 90 deletions(-)

-- 
2.7.4
