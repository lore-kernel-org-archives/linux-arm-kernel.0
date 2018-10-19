From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Oct 2018 13:26:25 +0100 (BST)
Subject: Applied "ASoC: dt-bindings: add mclk provider support to stm32 sai"
 to the asoc tree
In-Reply-To: <1539612216-12602-2-git-send-email-olivier.moysan@st.com>
Message-ID: <20181019122625.DD8F91122548@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: dt-bindings: add mclk provider support to stm32 sai

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From af16112457d8175b444baa9aac02558a1e1154b5 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 15 Oct 2018 16:03:33 +0200
Subject: [PATCH] ASoC: dt-bindings: add mclk provider support to stm32 sai

add mclk provider support to stm32 sai

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
