From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 11 May 2015 14:05:28 -0400
Subject: [v4.0: PATCH 1/3] ARM: dts: k2hk: fix the netcp range size
In-Reply-To: <1431367530-4924-1-git-send-email-m-karicheri2@ti.com>
References: <1431367530-4924-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1431367530-4924-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

k2hk netcp range size is 1M (0x100000) and not 0xfffff. This patch fixes
this.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/k2hk-netcp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/k2hk-netcp.dtsi b/arch/arm/boot/dts/k2hk-netcp.dtsi
index 308abe5..77a32c3 100644
--- a/arch/arm/boot/dts/k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/k2hk-netcp.dtsi
@@ -129,7 +129,7 @@ netcp: netcp at 2000000 {
 	#size-cells = <1>;
 
 	/* NetCP address range */
-	ranges  = <0 0x2000000 0xfffff>;
+	ranges  = <0 0x2000000 0x100000>;
 
 	clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
 	dma-coherent;
-- 
1.9.1
