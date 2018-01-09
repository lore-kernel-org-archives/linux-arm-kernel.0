From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:59:03 +0900
Subject: [PATCH 6/9] arm64: dts: exynos: Add iRAM device-tree node for
 Exynos5433
In-Reply-To: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075905epcas2p4aa0174854c0796cc7fa75bdf8a273791@epcas2p4.samsung.com>
Message-ID: <1515484746-10656-7-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the iRAM device-tree node of Exynos5433 which
defines the memory map of iRAM as following and it is used for suspend.
- address: 0x0202_0000 ~ 0x3000_0000

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 62f276970174..77f4321b247c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -262,6 +262,20 @@
 			interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
 		};
 
+		sysram at 02020000 {
+			compatible = "mmio-sram";
+			reg = <0x02020000 0x5c000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x02020000 0x5c000>;
+			status = "okay";
+
+			smp-sysram at 5b000 {
+				compatible = "samsung,exynos4210-sysram-ns";
+				reg = <0x5b000 0x1000>;
+			};
+		};
+
 		chipid at 10000000 {
 			compatible = "samsung,exynos4210-chipid";
 			reg = <0x10000000 0x100>;
-- 
1.9.1
