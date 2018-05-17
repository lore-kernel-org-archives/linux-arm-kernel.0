From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 17:41:46 +0100 (BST)
Subject: Applied "regulator: of: add property for allowed modes specification"
 to the regulator tree
In-Reply-To: <f3aa166ddd11c8f9813602be68aa5b10e5c90979.1526088289.git.collinsd@codeaurora.org>
Message-ID: <20180517164146.4A3B044007E@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: of: add property for allowed modes specification

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From d73e2842a3e236a1f58ba498e4d6ae58e18f660a Mon Sep 17 00:00:00 2001
From: David Collins <collinsd@codeaurora.org>
Date: Fri, 11 May 2018 18:46:46 -0700
Subject: [PATCH] regulator: of: add property for allowed modes specification

Add a common device tree property for regulator nodes to support
the specification of allowed operating modes.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 2babe15b618d..c627aa08f0da 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -59,6 +59,11 @@ Optional properties:
 - regulator-initial-mode: initial operating mode. The set of possible operating
   modes depends on the capabilities of every hardware so each device binding
   documentation explains which values the regulator supports.
+- regulator-allowed-modes: list of operating modes that software is allowed to
+  configure for the regulator at run-time.  Elements may be specified in any
+  order.  The set of possible operating modes depends on the capabilities of
+  every hardware so each device binding document explains which values the
+  regulator supports.
 - regulator-system-load: Load in uA present on regulator that is not captured by
   any consumer request.
 - regulator-pull-down: Enable pull down resistor when the regulator is disabled.
-- 
2.17.0
