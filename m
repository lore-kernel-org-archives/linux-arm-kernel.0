From: alexandre.torgue@gmail.com (Alexandre TORGUE)
Date: Mon,  9 May 2016 12:31:36 +0200
Subject: [RESEND PATCH v6 3/6] net: ethernet: stmmac: add support of Synopsys
 3.50a MAC IP
In-Reply-To: <1462789899-13153-1-git-send-email-alexandre.torgue@gmail.com>
References: <1462789899-13153-1-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <1462789899-13153-4-git-send-email-alexandre.torgue@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support of Synopsys 3.50a MAC IP in stmmac driver.

Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Tested-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 409db91..7718247 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -262,6 +262,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 	 * once needed on other platforms.
 	 */
 	if (of_device_is_compatible(np, "st,spear600-gmac") ||
+		of_device_is_compatible(np, "snps,dwmac-3.50a") ||
 		of_device_is_compatible(np, "snps,dwmac-3.70a") ||
 		of_device_is_compatible(np, "snps,dwmac")) {
 		/* Note that the max-frame-size parameter as defined in the
-- 
1.9.1
