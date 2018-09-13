From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:51 +0200
Subject: [PATCH 56/58] arm64: dts: renesas: enable SDR104 on R-Car Gen3
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <9bc03b57277c4272a9ef7c8c22672109d4416944.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Successfully tested on H3 ES1.0 and ES2.0, M3-W ES1.0, and M3-N ES1.0.
Even previously stubborn cards work fine. Transfer rates were >60MB/s.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 ++
 arch/arm64/boot/dts/renesas/ulcb.dtsi            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 3b90f816dfef..d298f7c9ada1 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -751,6 +751,7 @@
 	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
@@ -780,6 +781,7 @@
 	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 0ead552d7eae..7e6078508ba0 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -416,6 +416,7 @@
 	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.11.0
