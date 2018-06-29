From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 29 Jun 2018 11:45:27 -0700
Subject: [PATCH] arm64: dts: sdm845: Default qupv3_id_0 as "disabled" like
 _id_1
Message-ID: <20180629184527.161970-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 8e4947ee477d ("arm64: dts: qcom: sdm845: Add I2C, SPI, and
UART9 nodes") I accidentally forgot to add the line:

  status = "disabled";

to qupv3_id_0 to match qupv3_id_1.  Add it now.  NOTE: right now the
only sdm845 board with a device tree in mainline is MTP and that board
currently doesn't have any peripherals under qupv3_id_0.  If any board
was currently using peripherals under qupv3_id_0 then that board would
need to add this snippet to their board dts file:

  &qupv3_id_0 {
     status = "okay";
  };

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 00722b533a92..9c10ff5e5843 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -258,6 +258,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			status = "disabled";
 
 			i2c0: i2c at 880000 {
 				compatible = "qcom,geni-i2c";
-- 
2.18.0.399.gad0ab374a1-goog
