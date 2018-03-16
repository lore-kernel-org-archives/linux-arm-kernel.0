From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:36 +0100
Subject: [PATCH 06/69] arm64: dts: renesas: salvator-common: add GPIO extender
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <ece30287af4e08e681f27c3d58853b68cdde658b.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We need to configure its GPIOs later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index c3fafb6025b3..89cbb3b95acd 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -338,6 +338,13 @@
 &i2c4 {
 	status = "okay";
 
+	pca9654: gpio at 20 {
+		compatible = "onnn,pca9654";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	csa_vdd: adc at 7c {
 		compatible = "maxim,max9611";
 		reg = <0x7c>;
-- 
2.11.0
