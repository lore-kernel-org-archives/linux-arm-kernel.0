From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Jul 2017 21:56:46 +0900
Subject: [PATCH 0/3] mmc: sdhci: refactor PM in sdhci-pltfm and support PM for
 cadence port
Message-ID: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[1] adds clk handling for suspend/resume hooks of sdhci-pltfm.
    This also cleans up sdhci-brcmstb.c and sdhci-sirf.c

[2] exports suspend / resume, which will be used by [3]

[3] implements suspend / resume for sdhci-cadence.c



Masahiro Yamada (3):
  mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
  mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume
  mmc: sdhci-cadence: add suspend / resume support

 drivers/mmc/host/sdhci-brcmstb.c | 37 +------------------
 drivers/mmc/host/sdhci-cadence.c | 77 +++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-pltfm.c   | 22 ++++++++++--
 drivers/mmc/host/sdhci-pltfm.h   |  2 ++
 drivers/mmc/host/sdhci-sirf.c    | 39 +-------------------
 5 files changed, 91 insertions(+), 86 deletions(-)

-- 
2.7.4
