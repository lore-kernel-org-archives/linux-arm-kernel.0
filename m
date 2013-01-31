From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:26:07 +0900
Subject: [PATCH 2/4] ARM: mach-shmobile: emev2: Add reg and device_type
 properties to cpus
In-Reply-To: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613569-26981-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index eb504a6..c8a8c08 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -15,11 +15,18 @@
 	interrupt-parent = <&gic>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <0>;
 		};
 		cpu at 1 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <1>;
 		};
 	};
 
-- 
1.7.10.4
