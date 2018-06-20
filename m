From: h.grohne@intenta.de (Helmut Grohne)
Date: Wed, 20 Jun 2018 13:32:51 +0200
Subject: [PATCH v3 1/2] dt-bindings: mmc: broken clock stable indicator on
 arasan controllers
In-Reply-To: <cover.1529493667.git.h.grohne@intenta.de>
References: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
 <cover.1529493667.git.h.grohne@intenta.de>
Message-ID: <12953dbf9af1f1a71aaf3ef77782e56a2a7ad893.1529493667.git.h.grohne@intenta.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers immediately report that their internal clock is stable
after activating it even when the clock is not stable. When used in
conjunction with older/slower cards, this can result in:

    mmc0: error -84 whilst initialising SD card

This flag allows documenting and thus working around such a hardware
defect.

Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 60481bfc3d31..28332b655d2e 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -39,6 +39,8 @@ Optional Properties:
   - xlnx,fails-without-test-cd: when present, the controller doesn't work when
     the CD line is not connected properly, and the line is not connected
     properly. Test mode can be used to force the controller to function.
+  - xlnx,int-clock-stable-broken: when present, the controller always reports
+    that the internal clock is stable even when it is not.
 
 Example:
 	sdhci at e0100000 {
-- 
2.11.0
