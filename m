From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  4 Jan 2016 02:18:28 +0100
Subject: [PATCH] ARM: nomadik: set latencies to 8 cycles
Message-ID: <1451870308-19245-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik has sporadic crashes because of these latencies, setting
them to max makes the platform work nicely, so use this values for
now.

These latencies were set to 2 since the Nomadik platform was merged,
but I suspect they never took effect until the right size and
associativity for the cache was specified in the device tree and
that is why the crash comes now.

Cc: stable at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for fixes at your
convenience.
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 314f59c12162..d0c743853318 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -25,9 +25,9 @@
 		cache-sets = <512>;
 		cache-line-size = <32>;
 		/* At full speed latency must be >=2 */
-		arm,tag-latency = <2>;
-		arm,data-latency = <2 2>;
-		arm,dirty-latency = <2>;
+		arm,tag-latency = <8>;
+		arm,data-latency = <8 8>;
+		arm,dirty-latency = <8>;
 	};
 
 	mtu0: mtu at 101e2000 {
-- 
2.4.3
