From: addy.ke@rock-chips.com (Addy Ke)
Date: Thu,  5 Feb 2015 19:50:45 +0800
Subject: [PATCH v2] mmc: core: add runtime-resume caps to support resume at
 runtime_resume
In-Reply-To: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
References: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1423137045-23845-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
Changes in v2:
 - fix some typo 

 Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
 drivers/mmc/core/host.c                       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 438899e..a7b800e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -40,6 +40,7 @@ Optional properties:
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
 - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
+- runtime-resume: resume at runtime_resume is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df7..cb44c85 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -422,6 +422,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_POWER_OFF_CARD;
 	if (of_find_property(np, "cap-sdio-irq", &len))
 		host->caps |= MMC_CAP_SDIO_IRQ;
+	if (of_find_property(np, "runtime-resume", &len))
+		host->caps |= MMC_CAP_RUNTIME_RESUME;
 	if (of_find_property(np, "full-pwr-cycle", &len))
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (of_find_property(np, "keep-power-in-suspend", &len))
-- 
1.8.3.2
