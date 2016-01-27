From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 23:24:11 +0100
Subject: [PATCH 2/2] ARM: nomadik: get the cache running normally
Message-ID: <1453933451-6716-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There were earlier problems with the L210 cache on the Nomadik.
It turns out that to run the cache at full speed, you need to
set the "write allocate override" bit in the auxilary control
register. Now that this bit can be set from the device tree, we
can set down the latencies to 2 again.

Cc: stable at vger.kernel.org
Fixes: a461a3ecfc7e ("ARM: nomadik: set latencies to 8 cycles")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index d0c743853318..50c256f0fd98 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -25,9 +25,10 @@
 		cache-sets = <512>;
 		cache-line-size = <32>;
 		/* At full speed latency must be >=2 */
-		arm,tag-latency = <8>;
-		arm,data-latency = <8 8>;
-		arm,dirty-latency = <8>;
+		arm,tag-latency = <2>;
+		arm,data-latency = <2 2>;
+		arm,dirty-latency = <2>;
+		arm,write-allocate-override;
 	};
 
 	mtu0: mtu at 101e2000 {
-- 
2.4.3
