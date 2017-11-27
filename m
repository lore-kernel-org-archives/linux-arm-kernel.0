From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Nov 2017 18:53:21 +0000
Subject: Applied "ASoC: stm32: fix sync property description in SAI bindings"
 to the asoc tree
In-Reply-To: <1511362947-14747-2-git-send-email-olivier.moysan@st.com>
Message-ID: <E1eJOWv-0007GX-88@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: fix sync property description in SAI bindings

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

>From 4be0ffdf284046eb7289fa66cc7b2eb8d7efdc64 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Wed, 22 Nov 2017 16:02:25 +0100
Subject: [PATCH] ASoC: stm32: fix sync property description in SAI bindings

SAI sync property must be described in SAI subnodes
section, as it is a property of child node.
This patch fixes commit 14f0e5f8d97e632695d92f41f2e91d10d8005d47
"ASoC: stm32: Add synchronization to SAI bindings".

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index 1f9cd7095337..b1acc1a256ba 100644
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
2.15.0
