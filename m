From: alexandre.torgue@gmail.com (Alexandre TORGUE)
Date: Fri, 18 Mar 2016 16:37:07 +0100
Subject: [PATCH v5 3/4] net: ethernet: stmmac: add support of Synopsys 3.50a
 MAC IP
In-Reply-To: <1458315428-10081-1-git-send-email-alexandre.torgue@gmail.com>
References: <1458315428-10081-1-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <1458315428-10081-4-git-send-email-alexandre.torgue@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support of Synopsys 3.50a MAC IP in stmmac driver.

Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Tested-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6a52fa1..6cca626 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -178,6 +178,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 	 * once needed on other platforms.
 	 */
 	if (of_device_is_compatible(np, "st,spear600-gmac") ||
+		of_device_is_compatible(np, "snps,dwmac-3.50a") ||
 		of_device_is_compatible(np, "snps,dwmac-3.70a") ||
 		of_device_is_compatible(np, "snps,dwmac")) {
 		/* Note that the max-frame-size parameter as defined in the
-- 
1.9.1
