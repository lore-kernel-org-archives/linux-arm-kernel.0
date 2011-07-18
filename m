From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 18 Jul 2011 22:05:12 +0200
Subject: [PATCH] orion5x: fixup 5181 MPP mask check
Message-ID: <1311019512-26799-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the refactoring of the Orion MPP code, the detection for
the 5181l as been used to select the 5181 MPP mask, which is wrong.
Select the 5181 mask for all 5181 variants.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/mach-orion5x/mpp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index f12c41b..b6ddd7a 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -24,7 +24,7 @@ static unsigned int __init orion5x_variant(void)
 
 	orion5x_pcie_id(&dev, &rev);
 
-	if (dev == MV88F5181_DEV_ID && rev >= MV88F5181L_REV_A0)
+	if (dev == MV88F5181_DEV_ID)
 		return MPP_F5181_MASK;
 
 	if (dev == MV88F5182_DEV_ID)
-- 
1.7.1
