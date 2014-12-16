From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 16 Dec 2014 22:21:02 +0100
Subject: [PATCHv2 7/8] arm: dts: zynq: update isl9305 compatible string to use
 isil vendor prefix
In-Reply-To: <cover.1418763328.git.arno@natisbad.org>
References: <cover.1418763328.git.arno@natisbad.org>
Message-ID: <0bb79384219de2b55148d6f127c0c0c8deaaf4ea.1418763328.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


"isil" and "isl" prefixes are used at various locations inside the kernel
to reference Intersil corporation. This patch is part of a series fixing
those locations were "isl" is used in compatible strings to use the now
expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
version).

Note: isl9305 is an I2C device so the patch does not in fact currently
depend on the introduction of "isil"-based compatible string in isl9305
driver (provided by another patch) because I2C core does not check the
prefix yet.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/zynq-parallella.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index ab1dc0a56cdd..174571232ea5 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -58,7 +58,7 @@
 	status = "okay";
 
 	isl9305: isl9305 at 68 {
-		compatible = "isl,isl9305";
+		compatible = "isil,isl9305";
 		reg = <0x68>;
 
 		regulators {
-- 
2.1.1
