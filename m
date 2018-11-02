From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 2 Nov 2018 09:12:48 +0000
Subject: [PATCH V4 03/10] dt-bindings: gpio: vf610: add optional clocks
 property
In-Reply-To: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541149669-10857-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some SoCs(e.g. MX7ULP), GPIO clock is gatable and maybe
disabled by default. Users have to make sure it's enabled before
being able to access controller registers, otherwise an external
abort error may occur. Let's add the optional clocks property to
handle this case.

For ULP GPIO clock, it includes two separate clocks: one is for
GPIO controller Input/Output function clock while another is
GPIO port control clock for interrupt function.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: linux-gpio at vger.kernel.org
Cc: devicetree at vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * no changes
v1->v2:
 * new patch
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.txt b/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
index 0ccbae4..ae254aa 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.txt
@@ -24,6 +24,12 @@ Required properties for GPIO node:
       4 = active high level-sensitive.
       8 = active low level-sensitive.
 
+Optional properties:
+-clocks:	Must contain an entry for each entry in clock-names.
+		See common clock-bindings.txt for details.
+-clock-names:	A list of clock names. For imx7ulp, it must contain
+		"gpio", "port".
+
 Note: Each GPIO port should have an alias correctly numbered in "aliases"
 node.
 
-- 
2.7.4
