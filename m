From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:48 +0800
Subject: [PATCH 07/10] arm64: dts: zx296718: add irdec device for remote
 control
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-8-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Add irdec device for remote control support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 413de88b01db..d984da2b1143 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -295,6 +295,13 @@
 		compatible = "simple-bus";
 		ranges;
 
+		irdec: ir-decoder at 111000 {
+			compatible = "zte,zx296718-irdec";
+			reg = <0x111000 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		aon_sysctrl: aon-sysctrl at 116000 {
 			compatible = "zte,zx296718-aon-sysctrl", "syscon";
 			reg = <0x116000 0x1000>;
-- 
1.9.1
