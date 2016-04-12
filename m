From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:46 +0800
Subject: [PATCH v4 10/16] arm64: dts: add mailbox node for Hi6220
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-11-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

This patch add device mailbox node for Hi6220 in DT.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 4d1d31f..d71c51f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -647,5 +647,13 @@
 			g-tx-fifo-size = <128 128 128 128 128 128>;
 			interrupts = <0 77 0x4>;
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
