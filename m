From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Mon,  9 Oct 2017 15:11:51 +0100
Subject: [PATCH v3 6/7] nvmem: imx-ocotp: Enable i.MX7D OTP write support
In-Reply-To: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
References: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507558312-20580-7-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After applying patches for both banked access and write timings we can
re-enable the OTP write interface on i.MX7D processors.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
---
 drivers/nvmem/imx-ocotp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index f80aee9..8e8bc20 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -459,8 +459,6 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
 	priv->config = &imx_ocotp_nvmem_config;
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-ocotp"))
-		imx_ocotp_nvmem_config.read_only = true;
 	nvmem = nvmem_register(&imx_ocotp_nvmem_config);
 
 	if (IS_ERR(nvmem))
-- 
2.7.4
