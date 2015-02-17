From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Feb 2015 19:52:04 +0100
Subject: [PATCH 3/8] ARM: dts: dove: Fix uart[23] reg property
In-Reply-To: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1424199129-22099-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix Dove's register addresses of uart2 and uart3 nodes that seem to
be broken since ages due to a copy-and-paste error.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Please consider for stable back to v3.7

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index a5441d5482a6..3cc8b8320345 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -154,7 +154,7 @@
 
 			uart2: serial at 12200 {
 				compatible = "ns16550a";
-				reg = <0x12000 0x100>;
+				reg = <0x12200 0x100>;
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&core_clk 0>;
@@ -163,7 +163,7 @@
 
 			uart3: serial at 12300 {
 				compatible = "ns16550a";
-				reg = <0x12100 0x100>;
+				reg = <0x12300 0x100>;
 				reg-shift = <2>;
 				interrupts = <10>;
 				clocks = <&core_clk 0>;
-- 
2.1.0
