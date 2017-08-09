From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:45 +0800
Subject: [PATCH 04/10] arm64: dts: zx296718: set a better parent clock for I2S0
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The default I2S0 parent clock AUDIO_24M can not be divided into required
sample rate in some cases, for example when 48KHz is needed.  Change the
parent clock to AUDIO_99M which works for most sample rates.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 53bd504b4400..507bc39be96b 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -566,6 +566,8 @@
 			clocks = <&audiocrm AUDIO_I2S0_WCLK>,
 				 <&audiocrm AUDIO_I2S0_PCLK>;
 			clock-names = "wclk", "pclk";
+			assigned-clocks = <&audiocrm I2S0_WCLK_MUX>;
+			assigned-clock-parents = <&topcrm AUDIO_99M>;
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dma 22>, <&dma 23>;
 			dma-names = "tx", "rx";
-- 
1.9.1
