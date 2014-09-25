From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 25 Sep 2014 18:28:30 +0200
Subject: [PATCH v3 03/13] PM / Domains: Add DT bindings for PM QoS device
 latencies
In-Reply-To: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1411662520-22795-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM QoS device start/stop and save/restore state latencies are more or
less properties of the hardware.
In legacy code, they're specified from platform code.
On DT platforms, their values should come from DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should these properties be called "linux,*-latency"?

v3:
  - No changes
v2:
  - New

 Documentation/devicetree/bindings/power/power_domain.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 7bc421d84367d636..024815bc257723b1 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -42,12 +42,22 @@ Required properties:
  - power-domains : A phandle and PM domain specifier as defined by bindings of
                    the power controller specified by phandle.
 
+Optional properties:
+ - stop-latency: Stop latency of the device, in ns,
+ - start-latency: Start latency of the device, in ns,
+ - save-state-latency: Save-state latency of the device, in ns,
+ - restore-state-latency: Restore-state latency of the device, in ns.
+
 Example:
 
 	leaky-device at 12350000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12350000 0x1000>;
 		power-domains = <&power 0>;
+		stop-latency = <250000>;
+		start-latency = <250000>;
+		save-state-latency = <250000>;
+		restore-state-latency = <250000>;
 	};
 
 The node above defines a typical PM domain consumer device, which is located
-- 
1.9.1
