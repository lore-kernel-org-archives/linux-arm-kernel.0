From: dianders@chromium.org (Douglas Anderson)
Date: Mon, 14 May 2018 21:43:06 -0700
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Sort nodes in the reserved mem
 by address
Message-ID: <20180515044306.40735-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's keep the reserved-memory node tidy and neat and keep it sorted
by address.  This should have no functional change.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Oops!  v1 accidentally changed the node name.  Fixed.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 7c85e7c596db..73f71061fef8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -31,6 +31,12 @@
 			no-map;
 		};
 
+		memory at 85fe0000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x85fe0000 0x0 0x20000>;
+			no-map;
+		};
+
 		smem_mem: memory at 86000000 {
 			reg = <0x0 0x86000000 0x0 0x200000>;
 			no-map;
@@ -40,12 +46,6 @@
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
-
-		memory at 85fe0000 {
-			compatible = "qcom,cmd-db";
-			reg = <0x0 0x85fe0000 0x0 0x20000>;
-			no-map;
-		};
 	};
 
 	cpus {
-- 
2.17.0.441.gb46fe60e1d-goog
