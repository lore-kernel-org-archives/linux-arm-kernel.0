From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Apr 2018 15:28:30 +0200
Subject: [PATCH 4/8] sh_eth: Change platform check to CONFIG_ARCH_RENESAS
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1524230914-10175-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
is CONFIG_ARCH_RENESAS a more appropriate platform check than the legacy
CONFIG_ARCH_SHMOBILE, hence use the former.

Renesas SuperH SH-Mobile SoCs are still covered by the CONFIG_CPU_SH4
check.

This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/renesas/sh_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.h b/drivers/net/ethernet/renesas/sh_eth.h
index a5b792ce2ae7d046..1bf930d4a1e52c18 100644
--- a/drivers/net/ethernet/renesas/sh_eth.h
+++ b/drivers/net/ethernet/renesas/sh_eth.h
@@ -163,7 +163,7 @@ enum {
 };
 
 /* Driver's parameters */
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_RENESAS)
 #define SH_ETH_RX_ALIGN		32
 #else
 #define SH_ETH_RX_ALIGN		2
-- 
2.7.4
