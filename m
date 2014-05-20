From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 May 2014 16:09:28 -0500
Subject: [PATCH 02/10] dts: versatile: add missing irq controller properties
In-Reply-To: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
Message-ID: <1400620176-7239-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add valid-mask, clear-mask and passthru-mask properties to the dts so
the platform code doing the same thing can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/versatile-ab.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index e01e5a0..90a9f61 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -59,6 +59,8 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			reg = <0x10140000 0x1000>;
+			clear-mask = <0xffffffff>;
+			valid-mask = <0xffffffff>;
 		};
 
 		sic: intc at 10003000 {
@@ -68,6 +70,9 @@
 			reg = <0x10003000 0x1000>;
 			interrupt-parent = <&vic>;
 			interrupts = <31>; /* Cascaded to vic */
+			clear-mask = <0xffffffff>;
+			valid-mask = <0xffc203f8>;
+			passthru-mask = <0xffd00000>;
 		};
 
 		dma at 10130000 {
-- 
1.9.1
