From: olivier.moysan@st.com (Olivier Moysan)
Date: Wed, 22 Nov 2017 16:02:25 +0100
Subject: [PATCH 1/3] ASoC: stm32: fix sync property description in SAI bindings
In-Reply-To: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
References: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1511362947-14747-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SAI sync property must be described in SAI subnodes
section, as it is a property of child node.
This patch fixes commit 14f0e5f8d97e632695d92f41f2e91d10d8005d47
"ASoC: stm32: Add synchronization to SAI bindings".

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index 1f9cd70..b1acc1a 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -20,11 +20,6 @@ Required properties:
 
 Optional properties:
   - resets: Reference to a reset controller asserting the SAI
-  - st,sync: specify synchronization mode.
-	By default SAI sub-block is in asynchronous mode.
-	This property sets SAI sub-block as slave of another SAI sub-block.
-	Must contain the phandle and index of the sai sub-block providing
-	the synchronization.
 
 SAI subnodes:
 Two subnodes corresponding to SAI sub-block instances A et B can be defined.
@@ -44,6 +39,13 @@ SAI subnodes required properties:
   - pinctrl-names: should contain only value "default"
   - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
 
+SAI subnodes Optional properties:
+  - st,sync: specify synchronization mode.
+	By default SAI sub-block is in asynchronous mode.
+	This property sets SAI sub-block as slave of another SAI sub-block.
+	Must contain the phandle and index of the sai sub-block providing
+	the synchronization.
+
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
 graph.txt.
-- 
1.9.1
