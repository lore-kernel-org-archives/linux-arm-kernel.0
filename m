From: leo.yan@linaro.org (Leo Yan)
Date: Mon,  1 Feb 2016 21:34:46 +0800
Subject: [PATCH v5 3/4] arm64: dts: add mailbox node for Hi6220
In-Reply-To: <1454333687-20421-1-git-send-email-leo.yan@linaro.org>
References: <1454333687-20421-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1454333687-20421-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add device mailbox node for Hi6220 in DT.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 2585236..be3d962 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -249,5 +249,17 @@
 			clocks = <&ao_ctrl 27>;
 			clock-names = "apb_pclk";
 		};
+
+		mailbox: mailbox at f7510000 {
+			#mbox-cells = <1>;
+			compatible = "hisilicon,hi6220-mbox";
+			reg = <0x0 0xf7510000 0x0 0x1000>, /* IPC_S */
+			      <0x0 0x06dff800 0x0 0x0800>; /* Mailbox buffer */
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			mbox_stub_clock: mbox_stub_clock {
+				hi6220,mbox-rx = <0 1 10>;
+				hi6220,mbox-tx = <1 0 11>;
+			};
+		};
 	};
 };
-- 
1.9.1
