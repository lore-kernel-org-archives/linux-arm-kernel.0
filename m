From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 17:10:49 +0800
Subject: [PATCH v2 13/13] dt-bindings: usb: mtu3: remove optional pinctrls
In-Reply-To: <6dc39e99240f25c83f8c36d23361ec89dcfb33ce.1507885126.git.chunfeng.yun@mediatek.com>
References: <6dc39e99240f25c83f8c36d23361ec89dcfb33ce.1507885126.git.chunfeng.yun@mediatek.com>
Message-ID: <7829c4747d35a24cfc1497268a3642435ccfc2a2.1507885127.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove optional pinctrls due to using FORCE/RG_IDDIG to implement
manual switch function.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index 49c982b..b2271d8 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -30,9 +30,10 @@ Optional properties:
 	when supports dual-role mode.
  - vbus-supply : reference to the VBUS regulator, needed when supports
 	dual-role mode.
- - pinctl-names : a pinctrl state named "default" must be defined,
-	"id_float" and "id_ground" are optinal which depends on
-	"mediatek,enable-manual-drd"
+ - pinctrl-names : a pinctrl state named "default" is optional, and need be
+	defined if auto drd switch is enabled, that means the property dr_mode
+	is set as "otg", and meanwhile the property "mediatek,enable-manual-drd"
+	is not set.
  - pinctrl-0 : pin control group
 	See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
-- 
1.7.9.5
