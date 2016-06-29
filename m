From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 29 Jun 2016 12:07:33 +0100
Subject: [PATCH 3/3] arm64: tegra: Correct Tegra210 XUSB mailbox interrupt
In-Reply-To: <1467198453-23406-1-git-send-email-jonathanh@nvidia.com>
References: <1467198453-23406-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1467198453-23406-4-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The XUSB mailbox interrupt for Tegra210 is 40 and not 49 which is for
the XUSB pad controller. For some Tegra210 boards, this is causing USB
connect and disconnect events to go undetected. Fix this by changing the
interrupt number for the XUSB mailbox to 40.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index efb0fd98b789..6bc60ea95d16 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -740,7 +740,7 @@
 		reg-names = "hcd", "fpci", "ipfs";
 
 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 
 		clocks = <&tegra_car TEGRA210_CLK_XUSB_HOST>,
 			 <&tegra_car TEGRA210_CLK_XUSB_HOST_SRC>,
-- 
2.1.4
