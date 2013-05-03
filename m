From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:31:50 +0100
Subject: [PATCH 04/63] ARM: ux500: Supply MMC DMA configuration via Device Tree
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When requesting a channel, a DMA client needs to pass some pieces of
information such as; request channel, device type, channel type and
direction etc. Normally we do this in the form of platform data, but
when DT is enabled we need to pass it using the driver's bindings
instead.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index d595e2c..86b35a1 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -604,6 +604,11 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80126000 0x1000>;
 			interrupts = <0 60 0x4>;
+
+			dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
+			       <&dma 29 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
 
@@ -611,6 +616,11 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80118000 0x1000>;
 			interrupts = <0 50 0x4>;
+
+			dmas = <&dma 32 0 0x2>, /* Logical - DevToMem */
+			       <&dma 32 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
 
@@ -618,6 +628,11 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80005000 0x1000>;
 			interrupts = <0 41 0x4>;
+
+			dmas = <&dma 28 0 0x2>, /* Logical - DevToMem */
+			       <&dma 28 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
 
@@ -632,6 +647,11 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80114000 0x1000>;
 			interrupts = <0 99 0x4>;
+
+			dmas = <&dma 42 0 0x2>, /* Logical - DevToMem */
+			       <&dma 42 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
 
-- 
1.7.10.4
