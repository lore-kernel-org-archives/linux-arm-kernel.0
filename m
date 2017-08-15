From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 16 Aug 2017 00:45:18 +0900
Subject: [PATCH v3 0/4] mmc: sdhci: refactor PM in sdhci-pltfm add support PM
 for cadence port
Message-ID: <1502811922-9346-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[1] implements suspend / resume for sdhci-cadence.c

[2] refactor sdhci-pxav2

[3] add clk handling for suspend/resume hooks of sdhci-pltfm.
    This also cleans up sdhci-brcmstb.c and sdhci-sirf.c

[4] export sdhci_pltfm_suspend/resume to reduce code duplication



Masahiro Yamada (4):
  mmc: sdhci-cadence: add suspend / resume support
  mmc: sdhci-pxav2: switch to managed clk and sdhci_pltfm_unregister()
  mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
  mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume

 drivers/mmc/host/sdhci-brcmstb.c | 37 +------------------
 drivers/mmc/host/sdhci-cadence.c | 79 +++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-pltfm.c   | 22 +++++++++--
 drivers/mmc/host/sdhci-pltfm.h   |  2 +
 drivers/mmc/host/sdhci-pxav2.c   | 30 ++++-----------
 drivers/mmc/host/sdhci-sirf.c    | 39 +-------------------
 6 files changed, 100 insertions(+), 109 deletions(-)

-- 
2.7.4
