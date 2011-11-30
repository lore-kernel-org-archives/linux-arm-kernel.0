From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 30 Nov 2011 12:42:18 -0200
Subject: [PATCH v3] net: fec: Select the FEC driver by default for i.MX SoCs
In-Reply-To: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
References: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1322664138-3245-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 230dec6 (net/fec: add imx6q enet support) the FEC driver is no 
longer built by default for i.MX SoCs.

Let the FEC driver be built by default again.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Suggested-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K??nig <u.kleine-koenig at pengutronix.de
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v2:
- Improve commit message
- Reorder the placement of the "default" line
Changes since v1: 
Move the FEC selection into Kconfig instead of .config file
 drivers/net/ethernet/freescale/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index c520cfd..5272f9d 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -24,6 +24,7 @@ config FEC
 	bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
 	depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
 		   ARCH_MXC || ARCH_MXS)
+	default ARCH_MXC || ARCH_MXS if ARM
 	select PHYLIB
 	---help---
 	  Say Y here if you want to use the built-in 10/100 Fast ethernet
-- 
1.7.1
