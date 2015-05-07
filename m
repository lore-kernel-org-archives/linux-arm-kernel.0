From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu,  7 May 2015 15:45:03 +0100
Subject: [PATCH 2/4] ARM: vexpress/ca9: Add unified-cache property to l2 cache
 node
In-Reply-To: <1431009905-29265-1-git-send-email-sudeep.holla@arm.com>
References: <1431009905-29265-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1431009905-29265-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Schwebel <r.schwebel@pengutronix.de>

Commit d9d1f3e2d711 ("ARM: l2c: check that DT files specify the required
"cache-unified" property") mandates to specify this required property.
Without this property, we get this boot warning:

"L2C: device tree omits to specify unified cache"

This patch adds "cache-unified" property to L2 cache node in vexpress
CA9 device tree.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca9.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 23662b5a5e9d..a411274e8b6b 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -170,6 +170,7 @@
 		compatible = "arm,pl310-cache";
 		reg = <0x1e00a000 0x1000>;
 		interrupts = <0 43 4>;
+		cache-unified;
 		cache-level = <2>;
 		arm,data-latency = <1 1 1>;
 		arm,tag-latency = <1 1 1>;
-- 
1.9.1
