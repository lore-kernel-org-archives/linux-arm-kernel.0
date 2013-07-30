From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 12:46:16 +0100
Subject: [PATCH 4/5] mmc: dw_mmc: Indicate that regulators may be absent
In-Reply-To: <1375184777-25404-1-git-send-email-broonie@kernel.org>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
Message-ID: <1375184777-25404-4-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Use regulator_get_optional() to tell the core that requests for regulators
can fail in a real system.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ee5f167..5424073 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2231,7 +2231,7 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	host->vmmc = devm_regulator_get(host->dev, "vmmc");
+	host->vmmc = devm_regulator_get_optional(host->dev, "vmmc");
 	if (IS_ERR(host->vmmc)) {
 		ret = PTR_ERR(host->vmmc);
 		if (ret == -EPROBE_DEFER)
-- 
1.8.3.2
