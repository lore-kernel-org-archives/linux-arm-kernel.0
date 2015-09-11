From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 21:08:27 +0100
Subject: [PATCH 3/6] hwrng: st: Provide DT bindings for ST's Random Number
 Generator
In-Reply-To: <1442002110-28733-1-git-send-email-lee.jones@linaro.org>
References: <1442002110-28733-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1442002110-28733-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/rng/st,rng.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/st,rng.txt

diff --git a/Documentation/devicetree/bindings/rng/st,rng.txt b/Documentation/devicetree/bindings/rng/st,rng.txt
new file mode 100644
index 0000000..dbc64e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/st,rng.txt
@@ -0,0 +1,15 @@
+STMicroelectronics HW Random Number Generator
+----------------------------------------------
+
+Required parameters:
+compatible	: Should be "st,rng"
+reg		: Base address and size of IP's register map.
+clocks		: Phandle to device's clock (See: ../clocks/clock-bindings.txt)
+
+Example:
+
+rng at 0xfee80000 {
+	compatible      = "st,rng";
+	reg		= <0xfee80000 0x1000>;
+	clocks          = <&clk_sysin>;
+}
-- 
1.9.1
