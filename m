From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jul 2014 15:23:46 +0200
Subject: [PATCH 4/6] power: reset: DT bindings for the Versatile reset driver
In-Reply-To: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1406294628-16079-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree bindings for the Versatile reset driver.

Cc: devicetree at vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/reset/arm-versatile-reboot.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/arm-versatile-reboot.txt

diff --git a/Documentation/devicetree/bindings/reset/arm-versatile-reboot.txt b/Documentation/devicetree/bindings/reset/arm-versatile-reboot.txt
new file mode 100644
index 000000000000..fabb6cddf333
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/arm-versatile-reboot.txt
@@ -0,0 +1,18 @@
+ARM Versatile Family Reboot bindings
+
+Required nodes:
+
+- compatible: must be one of these to identify the system:
+   "arm,realview-eb-reboot"
+   "arm,realview-pb1176-reboot"
+   "arm,realview-pb11mp-reboot"
+   "arm,realview-pba8-reboot"
+   "arm,realview-pbx-reboot"
+- regmap : a phandle to a syscon node containing a regmap
+
+Example:
+
+reboot: reboot at 0x40 {
+	compatible = "arm,realview-pb1176-reboot";
+	regmap = <&syscon>;
+};
-- 
1.9.3
