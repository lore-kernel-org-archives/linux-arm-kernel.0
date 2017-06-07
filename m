From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  7 Jun 2017 11:08:20 +0200
Subject: [PATCH 1/3] dt-bindings: net: Add binding for the external clock for
 TI WiLink
In-Reply-To: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
References: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1496826502-1339-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The external clock is provided to the TI WiLink combo chip and it's needed
for any of the transport interfaces. However let's make it optional to
avoid breaking existing platforms that yet doesn't specify the clock.

Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/net/ti,wilink-st.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
index cbad73a..3404a4a 100644
--- a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
+++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
@@ -22,6 +22,10 @@ Optional properties:
  - enable-gpios : GPIO signal controlling enabling of BT. Active high.
  - vio-supply : Vio input supply (1.8V)
  - vbat-supply : Vbat input supply (2.9-4.8V)
+ - clocks : Must contain an entry, for each entry in clock-names.
+   See ../clocks/clock-bindings.txt for details.
+ - clock-names : Must include the following entry:
+   "ext_clock" (External clock provided to the TI combo chip).
 
 Example:
 
@@ -31,5 +35,7 @@ Example:
 	bluetooth {
 		compatible = "ti,wl1835-st";
 		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		clocks = <&clk32k_wl18xx>;
+		clock-names = "ext_clock";
 	};
 };
-- 
2.7.4
