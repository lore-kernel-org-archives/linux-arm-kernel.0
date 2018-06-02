From: vbhadram@nvidia.com (Bhadram Varka)
Date: Sat, 2 Jun 2018 14:41:53 +0530
Subject: [PATCH 3/3] arm64: tegra: Configure DWC EQOS TxPBL for multi-queue
In-Reply-To: <1527930713-4479-1-git-send-email-vbhadram@nvidia.com>
References: <1527930713-4479-1-git-send-email-vbhadram@nvidia.com>
Message-ID: <1527930713-4479-3-git-send-email-vbhadram@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PBL should be limited to half of the Queue size.

For multi-queue: Total MTL queue size 4KB.
PBL = 16, PBLx8 = 1 -> This setting would lead
to an effective burst = 8*16 = 128, which would
mean 128*16B = 2KB (half of queue size)

Signed-off-by: Bhadram Varka <vbhadram@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index f27730d..630cb81 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -101,7 +101,7 @@
 		snps,write-requests = <1>;
 		snps,read-requests = <3>;
 		snps,burst-map = <0x7>;
-		snps,txpbl = <32>;
+		snps,txpbl = <16>;
 		snps,rxpbl = <8>;
 		snps,mtl-rx-config = <&mtl_rx_setup>;
 		snps,mtl-tx-config = <&mtl_tx_setup>;
-- 
2.7.4
