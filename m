From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:11 -0500
Subject: [PATCH v2 01/11] dts: versatile: add missing irq controller properties
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add valid-mask and clear-mask properties to the versatile dts so the
platform code doing the same thing can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
- Drop the passthru-mask property

 arch/arm/boot/dts/versatile-ab.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index e01e5a0..5dc3be7 100644
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
@@ -68,6 +70,8 @@
 			reg = <0x10003000 0x1000>;
 			interrupt-parent = <&vic>;
 			interrupts = <31>; /* Cascaded to vic */
+			clear-mask = <0xffffffff>;
+			valid-mask = <0xffc203f8>;
 		};
 
 		dma at 10130000 {
-- 
1.9.1
