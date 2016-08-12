From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Aug 2016 13:29:46 +0100
Subject: Applied "ASoC: sunxi: Add bindings for sun6i to SPDIF" to the asoc
 tree
In-Reply-To: <20160730155638.24455-2-codekipper@gmail.com>
Message-ID: <E1bYBas-0002hU-56@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: Add bindings for sun6i to SPDIF

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fbb016a25dd0f4160df90bb1319e64e8209c7619 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Sat, 30 Jul 2016 17:56:37 +0200
Subject: [PATCH] ASoC: sunxi: Add bindings for sun6i to SPDIF

The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
reset is controlled via a separate reset controller.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
index 13503aa505a9..0230c4d20506 100644
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -9,6 +9,7 @@ Required properties:
 
   - compatible		: should be one of the following:
     - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
+    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
 
   - reg			: Offset and length of the register set for the device.
 
@@ -25,6 +26,8 @@ Required properties:
 	"apb"		  clock for the spdif bus.
 	"spdif"		  clock for spdif controller.
 
+  - resets		: reset specifier for the ahb reset (A31 and newer only)
+
 Example:
 
 spdif: spdif at 01c21000 {
-- 
2.8.1
