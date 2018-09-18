From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 18 Sep 2018 14:19:07 +0800
Subject: [PATCH 3/4] clk: imx6ul: add i.mx6ulz support
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1537251548-27845-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6ULZ has same CCM IP as i.MX6ULL, and it reuses
i.MX6UL clock driver, this patch adds support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 361b43f..42b857e 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -116,7 +116,8 @@ static inline int clk_on_imx6ul(void)
 
 static inline int clk_on_imx6ull(void)
 {
-	return of_machine_is_compatible("fsl,imx6ull");
+	return of_machine_is_compatible("fsl,imx6ull") ||
+		of_machine_is_compatible("fsl,imx6ulz");
 }
 
 static void __init imx6ul_clocks_init(struct device_node *ccm_node)
-- 
2.7.4
