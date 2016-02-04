From: leo.yan@linaro.org (Leo Yan)
Date: Thu,  4 Feb 2016 23:24:59 +0800
Subject: [PATCH v7 3/4] arm64: dts: add mailbox node for Hi6220
In-Reply-To: <1454599500-15600-1-git-send-email-leo.yan@linaro.org>
References: <1454599500-15600-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1454599500-15600-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add device mailbox node for Hi6220 in DT.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 2585236..23c79e1 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -249,5 +249,13 @@
 			clocks = <&ao_ctrl 27>;
 			clock-names = "apb_pclk";
 		};
+
+		mailbox: mailbox at f7510000 {
+			compatible = "hisilicon,hi6220-mbox";
+			reg = <0x0 0xf7510000 0x0 0x1000>, /* IPC_S */
+			      <0x0 0x06dff800 0x0 0x0800>; /* Mailbox buffer */
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <3>;
+		};
 	};
 };
-- 
1.9.1
