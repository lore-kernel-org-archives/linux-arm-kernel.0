From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 21 Dec 2016 16:03:42 -0600
Subject: [PATCH] arm64: dts: msm8996: Add required memory carveouts
Message-ID: <1482357822-20823-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

This patch adds required memory carveouts so that the kernel does not
access memory that is in use or has been reserved for use by other remote
processors.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cde4114..25e11dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -64,6 +64,16 @@
 			reg = <0x0 0x86000000 0x0 0x200000>;
 			no-map;
 		};
+
+		memory at 85800000 {
+			reg = <0x0 0x85800000 0x0 0x800000>;
+			no-map;
+		};
+
+		memory at 86200000 {
+			reg = <0x0 0x86200000 0x0 0x2600000>;
+			no-map;
+		};
 	};
 
 	cpus {
-- 
1.9.1
