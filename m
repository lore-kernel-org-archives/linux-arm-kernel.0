From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 15 Oct 2018 16:03:33 +0200
Subject: [PATCH 1/4] ASoC: dt-bindings: add mclk provider support to stm32 sai
In-Reply-To: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
References: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1539612216-12602-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add mclk provider support to stm32 sai

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index 3a3fc506e43a..3f4467ff0aa2 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -31,7 +31,11 @@ SAI subnodes required properties:
   - reg: Base address and size of SAI sub-block register set.
   - clocks: Must contain one phandle and clock specifier pair
 	for sai_ck which feeds the internal clock generator.
+	If the SAI shares a master clock, with another SAI set as MCLK
+	clock provider, SAI provider phandle must be specified here.
   - clock-names: Must contain "sai_ck".
+	Must also contain "MCLK", if SAI shares a master clock,
+	with a SAI set as MCLK clock provider.
   - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
   - dma-names: identifier string for each DMA request line
 	"tx": if sai sub-block is configured as playback DAI
@@ -51,6 +55,9 @@ SAI subnodes Optional properties:
 	configured according to protocol defined in related DAI link node,
 	such as i2s, left justified, right justified, dsp and pdm protocols.
 	Note: ac97 protocol is not supported by SAI driver
+   - #clock-cells: should be 0. This property must be present if the SAI device
+	is a master clock provider, according to clocks bindings, described in
+	Documentation/devicetree/bindings/clock/clock-bindings.txt.
 
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
-- 
2.7.4
