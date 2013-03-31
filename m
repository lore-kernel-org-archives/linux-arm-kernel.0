From: nigel@nobiscuit.com (Nigel Roberts)
Date: Sun, 31 Mar 2013 15:13:24 +1100
Subject: [PATCH 2/2] Fix GE0/GE1 init on ix2-200 as GE0 has no PHY
In-Reply-To: <1364703204-14982-1-git-send-email-nigel@nobiscuit.com>
References: <1364703204-14982-1-git-send-email-nigel@nobiscuit.com>
Message-ID: <1364703204-14982-3-git-send-email-nigel@nobiscuit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
index f655b26..e5f7041 100644
--- a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
+++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
@@ -20,10 +20,15 @@ static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
 	.duplex         = DUPLEX_FULL,
 };
 
+static struct mv643xx_eth_platform_data iomega_ix2_200_ge01_data = {
+        .phy_addr       = MV643XX_ETH_PHY_ADDR(11),
+};
+
 void __init iomega_ix2_200_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_ge01_init(&iomega_ix2_200_ge00_data);
+	kirkwood_ge00_init(&iomega_ix2_200_ge00_data);
+	kirkwood_ge01_init(&iomega_ix2_200_ge01_data);
 }
-- 
1.7.9.5
