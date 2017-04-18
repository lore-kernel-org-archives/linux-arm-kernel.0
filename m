From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Apr 2017 14:55:38 +0900
Subject: [PATCH/RFT 1/2] ARM: dts: r8a7793: set maximum frequency for SDHI
 clocks
In-Reply-To: <1492494939-24568-1-git-send-email-horms+renesas@verge.net.au>
References: <1492494939-24568-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1492494939-24568-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the upper limit otherwise the driver cannot utilize max speeds.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 4de6041d61f9..08b7b0f97909 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -542,6 +542,7 @@
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
 		       <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -554,6 +555,7 @@
 		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
 		       <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -566,6 +568,7 @@
 		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
 		       <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
-- 
2.7.0.rc3.207.g0ac5344
