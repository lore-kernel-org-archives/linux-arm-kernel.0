From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:56:09 +0900
Subject: [PATCH 4/5] ARM: shmobile: r8a7779: Remove lan from dtsi
In-Reply-To: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
References: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361242570-8867-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet controller is not part of the r8a7779 SoC.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 2913759..0016302 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -83,13 +83,4 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 0x4>;
 	};
-
-	lan0: lan0 at 18000000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x18000000 0x100>;
-		phy-mode = "mii";
-		interrupt-parent = <&gic>;
-		interrupts = <0 28 0x4>;
-		reg-io-width = <4>;
-	};
 };
-- 
1.7.10.4
