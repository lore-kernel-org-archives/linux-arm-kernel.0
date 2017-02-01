From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed,  1 Feb 2017 02:24:24 -0800
Subject: [PATCH] arm64: dts: apq8016-sbc: Add ramoops
Message-ID: <20170201102424.4017-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare a ramoops memory segment to aid debugging for those without UART
access. Verified to carry console log when holding volume down for 15
seconds.

I was unable to find any ramoops-like memory region used in the 8916
downstream kernels, so the picked region is the last MB in System RAM.

No memory region for ramoops-like support was found downstrea, so the
arbitrarily picked region is the last MB of System RAM.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Mart Raudsepp <leio@gentoo.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Enable CONFIG_PSTORE, CONFIG_PSTORE_CONSOLE and CONFIG_PSTORE_RAM.

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index a45bc1dba686..f93edf57f249 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -35,6 +35,17 @@
 		stdout-path = "serial0";
 	};
 
+	reserved-memory {
+		ramoops at bff00000{
+			compatible = "ramoops";
+			reg = <0x0 0xbff00000 0x0 0x100000>;
+
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x20000>;
+		};
+	};
+
 	soc {
 		dma at 7884000 {
 			status = "okay";
-- 
2.11.0
