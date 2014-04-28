From: george.cherian@ti.com (George Cherian)
Date: Mon, 28 Apr 2014 09:40:21 +0530
Subject: [PATCH 2/6] ARM: dts: am33xx: Add clock names for cpsw and cpts
In-Reply-To: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
Message-ID: <1398658225-25873-3-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPSW fck and CPTS clock and clock names

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9770e35..d1e2b36 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -665,6 +665,8 @@
 		mac: ethernet at 4a100000 {
 			compatible = "ti,cpsw";
 			ti,hwmods = "cpgmac0";
+			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
+			clock-names = "fck", "cpts";
 			cpdma_channels = <8>;
 			ale_entries = <1024>;
 			bd_ram_size = <0x2000>;
-- 
1.8.3.1
