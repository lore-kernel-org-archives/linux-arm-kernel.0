From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Apr 2013 18:27:47 +0200
Subject: [PATCH 6/6] ARM: shmobile: armadillo800eva-reference: add DMA support
 for MMCIF and SDHI
In-Reply-To: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
References: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1366993667-23294-7-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA bindings to SDHI and MMCIF DT nodes on armadillo800eva-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 3752637..c201445 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -47,6 +47,9 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
 	non-removable;
+	dmas = <&dma0 0xd1
+		&dma0 0xd2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
@@ -54,11 +57,17 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
 	broken-cd;
+	dmas = <&dma0 0xc1
+		&dma0 0xc2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
 &sdhi1 {
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
+	dmas = <&dma0 0xc9
+		&dma0 0xca>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
-- 
1.7.2.5
