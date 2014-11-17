From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 17 Nov 2014 14:30:37 +0100
Subject: [PATCH v5 1/8] PM / Domains: Add DT bindings for power-on/off
 latencies
In-Reply-To: <1416231044-1903-1-git-send-email-geert+renesas@glider.be>
References: <1416231044-1903-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1416231044-1903-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM domain power on/off-latencies are properties of the hardware.
In legacy code, they're specified from platform code.
On DT platforms, their values should come from DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kevin Hilman <khilman@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v5:
  - No changes,
v4:
  - Add Reviewed-by,
  - Replace single latency value by list of latencies,
v3:
  - No changes,
v2:
  - Add Acked-by.
---
 Documentation/devicetree/bindings/power/power_domain.txt | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 98c16672ab5f49e0..c4a4afb2ac3b0500 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -19,16 +19,26 @@ Required properties:
    providing multiple PM domains (e.g. power controllers), but can be any value
    as specified by device tree binding documentation of particular provider.
 
+Optional properties:
+ - power-on-latency: List of power-on latencies (in ns), one for each PM
+   domain. If all power-on latencies are identical, the list may be shortened
+   to a single value.
+ - power-off-latency: List of power-off latencies (in ns), one for each PM
+   domain. If all power-off latencies are identical, the list may be shortened
+   to a single value.
+
 Example:
 
 	power: power-controller at 12340000 {
 		compatible = "foo,power-controller";
 		reg = <0x12340000 0x1000>;
 		#power-domain-cells = <1>;
+		power-on-latency = <250000 400000 180000>;
+		power-off-latency = <250000 400000 300000>;
 	};
 
-The node above defines a power controller that is a PM domain provider and
-expects one cell as its phandle argument.
+The node above defines a power controller that is a PM domain provider for
+3 PM domains, and expects one cell as its phandle argument.
 
 ==PM domain consumers==
 
-- 
1.9.1
