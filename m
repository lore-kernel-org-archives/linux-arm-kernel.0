From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 29 Aug 2017 15:58:38 +0800
Subject: [PATCH 2/2] arm64: dts: hi6220: enable watchdog
In-Reply-To: <1503993518-24428-1-git-send-email-leo.yan@linaro.org>
References: <1503993518-24428-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1503993518-24428-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dmitry Shmidt <dimitrysh@google.com>

This patch is to add watchdog binding for Hi6220 on Hikey board.

Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index eacbe0d..77dc28f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -809,6 +809,14 @@
 			pinctrl-1 = <&sdio_pmx_idle &sdio_clk_cfg_idle &sdio_cfg_idle>;
 		};
 
+		watchdog0: watchdog at f8005000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			reg = <0x0 0xf8005000 0x0 0x1000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ao_ctrl HI6220_WDT0_PCLK>;
+			clock-names = "apb_pclk";
+		};
+
 		tsensor: tsensor at 0,f7030700 {
 			compatible = "hisilicon,tsensor";
 			reg = <0x0 0xf7030700 0x0 0x1000>;
-- 
2.7.4
