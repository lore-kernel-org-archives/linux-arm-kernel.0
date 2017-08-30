From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Aug 2017 18:57:22 +0100
Subject: Applied "regulator: Add STM32 Voltage Reference Buffer" to the
 regulator tree
In-Reply-To: <1499776233-29116-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <E1dn7Ew-0001IE-Tp@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: Add STM32 Voltage Reference Buffer

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From ef7bb293a670c7a81c7a5b8aad6b93ba32e0e9ec Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Date: Wed, 30 Aug 2017 17:55:27 +0200
Subject: [PATCH] regulator: Add STM32 Voltage Reference Buffer

Document STM32 VREFBUF (voltage reference buffer) which can be used as
voltage reference for ADCs, DACs and external components.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/st,stm32-vrefbuf.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
new file mode 100644
index 000000000000..3944ee3e731e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
@@ -0,0 +1,20 @@
+STM32 VREFBUF - Voltage reference buffer
+
+Some STM32 devices embed a voltage reference buffer which can be used as
+voltage reference for ADCs, DACs and also as voltage reference for external
+components through the dedicated VREF+ pin.
+
+Required properties:
+- compatible:		Must be "st,stm32-vrefbuf".
+- reg:			Offset and length of VREFBUF register set.
+- clocks:		Must contain an entry for peripheral clock.
+
+Example:
+	vrefbuf: regulator at 58003C00 {
+		compatible = "st,stm32-vrefbuf";
+		reg = <0x58003C00 0x8>;
+		clocks = <&rcc VREF_CK>;
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <2500000>;
+		vdda-supply = <&vdda>;
+	};
-- 
2.14.1
