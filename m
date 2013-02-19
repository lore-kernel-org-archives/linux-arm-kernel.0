From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:56:10 +0900
Subject: [PATCH 5/5] ARM: shmobile: marzen: Add lan to dts file
In-Reply-To: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
References: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361242570-8867-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet controller is part of the marzen board so add it to
the dts file.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 377d8df..72be4c8 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -33,9 +33,15 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
-};
 
-&lan0 {
-	vddvario-supply = <&fixedregulator3v3>;
-	vdd33a-supply = <&fixedregulator3v3>;
+	lan0 at 18000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18000000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&gic>;
+		interrupts = <0 28 0x4>;
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
 };
-- 
1.7.10.4
