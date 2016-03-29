From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 30 Mar 2016 00:30:40 +0200
Subject: [PATCH 1/7] ARM: dts: armv7-m: add unit name to interrupt-controller
In-Reply-To: <1459290646-3592-1-git-send-email-manabian@gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
Message-ID: <1459290646-3592-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add unit name to nvic to remove the following warning:
 Warning (unit_address_vs_reg): Node /nv-interrupt-controller has a reg
				or ranges property, but no unit name

Also correct the node name to 'interrupt-controller' while changing the
line.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/armv7-m.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
index b1ad7cf..16331aa 100644
--- a/arch/arm/boot/dts/armv7-m.dtsi
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -1,7 +1,7 @@
 #include "skeleton.dtsi"
 
 / {
-	nvic: nv-interrupt-controller  {
+	nvic: interrupt-controller at e000e100  {
 		compatible = "arm,armv7m-nvic";
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.7.4
