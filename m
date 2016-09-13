From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 Sep 2016 12:57:03 +0200
Subject: [PATCH v7 06/11] ARM: dts: r8a7794: set maximum frequency for SDHI
 clocks
In-Reply-To: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1473764228-24768-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the upper limit otherwise the driver cannot utilize max speeds.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 9365580a194f..57e0d27cb82e 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -731,6 +731,7 @@
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
 		       <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -743,6 +744,7 @@
 		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
 		       <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -755,6 +757,7 @@
 		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
 		       <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
-- 
2.7.0.rc3.207.g0ac5344
