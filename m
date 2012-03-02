From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  2 Mar 2012 07:45:59 -0300
Subject: [PATCH 2/2] ARM: mx35: Setup the AIPS registers
In-Reply-To: <1330685159-4137-1-git-send-email-festevam@gmail.com>
References: <1330685159-4137-1-git-send-email-festevam@gmail.com>
Message-ID: <1330685159-4137-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the AIPS registers on mx35.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx3.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 77cf553..cc8a707 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -260,5 +260,9 @@ void __init imx35_soc_init(void)
 	}
 
 	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
+
+	/* Setup AIPS registers */
+	imx_set_aips(MX35_IO_ADDRESS(MX35_AIPS1_BASE_ADDR));
+	imx_set_aips(MX35_IO_ADDRESS(MX35_AIPS2_BASE_ADDR));
 }
 #endif /* ifdef CONFIG_SOC_IMX35 */
-- 
1.7.1
