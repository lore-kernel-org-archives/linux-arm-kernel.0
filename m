From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 19 Feb 2018 16:00:35 +0100
Subject: [RFC PATCH 1/3] ASoC: stm32: Add S/PDIF to SAI bindings
In-Reply-To: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
References: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1519052437-24011-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add S/PDIF IEC6958 protocol support to STM32 SAI bindings.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index b1acc1a..f301cdf 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -45,6 +45,12 @@ SAI subnodes Optional properties:
 	This property sets SAI sub-block as slave of another SAI sub-block.
 	Must contain the phandle and index of the sai sub-block providing
 	the synchronization.
+  - st,iec60958: support S/PDIF IEC6958 protocol for playback
+	IEC60958 protocol is not available for capture.
+	By default, custom protocol is assumed, meaning that protocol is
+	configured according to protocol defined in related DAI link node,
+	such as i2s, left justified, right justified, dsp and pdm protocols.
+	Note: ac97 protocol is not supported by SAI driver
 
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
-- 
1.9.1
