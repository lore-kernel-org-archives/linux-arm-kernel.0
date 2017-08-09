From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:47 +0800
Subject: [PATCH 06/10] arm64: dts: zx296718: add PWM device support
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-7-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds PWM device support which will be used to control voltage of core
supply on some boards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 74c37e443627..413de88b01db 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -470,6 +470,16 @@
 			#clock-cells = <1>;
 		};
 
+		pwm: pwm at 1439000 {
+			compatible = "zte,zx296718-pwm";
+			reg = <0x1439000 0x1000>;
+			clocks = <&lsp1crm LSP1_PWM_PCLK>,
+				 <&lsp1crm LSP1_PWM_WCLK>;
+			clock-names = "pclk", "wclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		vou: vou at 1440000 {
 			compatible = "zte,zx296718-vou";
 			#address-cells = <1>;
-- 
1.9.1
