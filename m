From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:32 +0530
Subject: [PATCH 10/14] ARM: SPEAr13xx: Remove fields not required for ssp
 controller
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <5562298b700d7c63601d06b246d03a1946f57faa.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Few fields are not required to be programmed in platform data of spi controller
now, as it comes via DT. Remove them.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear13xx/spear1310.c | 2 --
 arch/arm/mach-spear13xx/spear13xx.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 593a756..451f3b1 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -34,9 +34,7 @@
 
 /* ssp device registration */
 static struct pl022_ssp_controller ssp1_plat_data = {
-	.bus_id = 0,
 	.enable_dma = 0,
-	.num_chipselect = 3,
 };
 
 /* Add SPEAr1310 auxdata to pass platform data */
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 5633d69..c4af775 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -57,12 +57,10 @@ static struct dw_dma_slave ssp_dma_param[] = {
 };
 
 struct pl022_ssp_controller pl022_plat_data = {
-	.bus_id = 0,
 	.enable_dma = 1,
 	.dma_filter = dw_dma_filter,
 	.dma_rx_param = &ssp_dma_param[1],
 	.dma_tx_param = &ssp_dma_param[0],
-	.num_chipselect = 3,
 };
 
 /* CF device registration */
-- 
1.7.12.rc2.18.g61b472e
