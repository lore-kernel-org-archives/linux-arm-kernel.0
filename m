From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Jun 2011 17:12:10 -0300
Subject: [PATCH 3/4] ARM: mx51: Fix the address space length for SSI
In-Reply-To: <1309205531-18103-2-git-send-email-fabio.estevam@freescale.com>
References: <1309205531-18103-1-git-send-email-fabio.estevam@freescale.com>
	<1309205531-18103-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1309205531-18103-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MX51 the address space length for SSI is 16KB.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/devices/platform-imx-ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
index a0915d6..21c6f30 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -69,7 +69,7 @@ const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst = {
 #ifdef CONFIG_SOC_IMX51
 const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst = {
 #define imx51_imx_ssi_data_entry(_id, _hwid)				\
-	imx_imx_ssi_data_entry(MX51, _id, _hwid, SZ_4K)
+	imx_imx_ssi_data_entry(MX51, _id, _hwid, SZ_16K)
 	imx51_imx_ssi_data_entry(0, 1),
 	imx51_imx_ssi_data_entry(1, 2),
 	imx51_imx_ssi_data_entry(2, 3),
-- 
1.6.0.4
