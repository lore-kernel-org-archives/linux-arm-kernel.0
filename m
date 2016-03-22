From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:38 +0900
Subject: [PATCH 11/13] ARM: dts: koelsch: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458610840-15194-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Fixed rate and fixed factor clocks do not require an
  clock-output-names property.
* Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
  optional") Renesas div6 clocks do not require a clock-output-names
  property.

In the above cases there is only one clock output and its name is taken
from that of the clock node.  Accordingly, remove the unnecessary
clock-output-names properties and as necessary update the node names.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 0ad71b81d3a2..6eda659e0d98 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -242,11 +242,10 @@
 			  1800000 0>;
 	};
 
-	audio_clock: clock {
+	audio_clock: audio_clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <11289600>;
-		clock-output-names = "audio_clock";
 	};
 
 	rsnd_ak4643: sound {
-- 
2.1.4
