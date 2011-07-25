From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jul 2011 17:46:31 -0300
Subject: [PATCH] ARM: board-mx51_babbage: Fix UART2 registration
Message-ID: <1311626791-7197-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MX51 Babbage board the RTS/CTS pins are not used on UART2 port.

Fix the registration of this port.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 15c6000..62aa2af 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -367,7 +367,7 @@ static void __init mx51_babbage_init(void)
 					ARRAY_SIZE(mx51babbage_pads));
 
 	imx51_add_imx_uart(0, &uart_pdata);
-	imx51_add_imx_uart(1, &uart_pdata);
+	imx51_add_imx_uart(1, NULL);
 	imx51_add_imx_uart(2, &uart_pdata);
 
 	babbage_fec_reset();
-- 
1.7.1
