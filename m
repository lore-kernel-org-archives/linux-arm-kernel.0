From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Tue, 15 May 2018 14:05:53 +0800
Subject: [PATCH] ARM: dts: berlin2q: add "cache-unified" to l2 node
Message-ID: <20180515140553.7e4d7c9d@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this property, we get this boot warning:

"L2C: device tree omits to specify unified cache"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index e23c49ae3ec2..7cba798152b9 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -149,6 +149,7 @@
 		l2: l2-cache-controller at ac0000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
+			cache-unified;
 			cache-level = <2>;
 			arm,data-latency = <2 2 2>;
 			arm,tag-latency = <2 2 2>;
-- 
2.17.0
