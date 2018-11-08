From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  8 Nov 2018 14:53:50 +0100
Subject: [PATCH 2/4] arm64: dts: meson-axg: correct sram shared mem
 unit-address
In-Reply-To: <20181108135352.8459-1-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
Message-ID: <20181108135352.8459-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the unit-address in the node name of the SRAM shared memory

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index ff8b3406aff6..b8893675e39c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1659,12 +1659,12 @@
 			#size-cells = <1>;
 			ranges = <0 0x0 0xfffc0000 0x20000>;
 
-			cpu_scp_lpri: scp-shmem at 0 {
+			cpu_scp_lpri: scp-shmem at 13000 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem at 200 {
+			cpu_scp_hpri: scp-shmem at 13400 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
-- 
2.19.1
