From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 May 2015 10:55:19 -0600
Subject: [PATCH 14/16] coresight: document the bindings for the ATCLK
In-Reply-To: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
References: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1432054521-24807-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Put in a blurb in the device tree bindings indicating that
coresight blocks may have an optional ATCLK.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 88602b75418e..8711c1065479 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -21,11 +21,14 @@ its hardware characteristcs.
 	* reg: physical base address and length of the register
 	  set(s) of the component.
 
-	* clocks: the clock associated to this component.
-
-	* clock-names: the name of the clock as referenced by the code.
-	  Since we are using the AMBA framework, the name should be
-	  "apb_pclk".
+	* clocks: the clocks associated to this component.
+
+	* clock-names: the name of the clocks referenced by the code.
+	  Since we are using the AMBA framework, the name of the clock
+	  providing the interconnect should be "apb_pclk", and some
+	  coresight blocks also have an additional clock "atclk", which
+	  clocks the core of that coresight component. The latter clock
+	  is optional.
 
 	* port or ports: The representation of the component's port
 	  layout using the generic DT graph presentation found in
-- 
1.9.1
