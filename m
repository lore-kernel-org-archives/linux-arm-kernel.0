From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 11 May 2015 14:05:29 -0400
Subject: [v4.0: PATCH 2/3] ARM: dts: k2e: fix the netcp range size
In-Reply-To: <1431367530-4924-1-git-send-email-m-karicheri2@ti.com>
References: <1431367530-4924-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1431367530-4924-3-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

k2e netcp range size is 16M (0x1000000) and not 0xffffff. This patch fixes
this. Similarly fix the size of switch module register space to 0x20000.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/k2e-netcp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/k2e-netcp.dtsi b/arch/arm/boot/dts/k2e-netcp.dtsi
index 4ab94c3..b13b3c9 100644
--- a/arch/arm/boot/dts/k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/k2e-netcp.dtsi
@@ -113,7 +113,7 @@ netcp: netcp at 24000000 {
 	#size-cells = <1>;
 
 	/* NetCP address range */
-	ranges = <0 0x24000000 0xffffff>;
+	ranges = <0 0x24000000 0x1000000>;
 
 	clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
 	dma-coherent;
@@ -130,7 +130,7 @@ netcp: netcp at 24000000 {
 		gbe at 200000 { /* ETHSS */
 			label = "netcp-gbe";
 			compatible = "ti,netcp-gbe-9";
-			reg = <0x200000 0x900>, <0x220000 0x1ffff>;
+			reg = <0x200000 0x900>, <0x220000 0x20000>;
 			/* enable-ale; */
 			tx-queue = <896>;
 			tx-channel = "nettx";
-- 
1.9.1
