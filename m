From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 16 Mar 2018 00:07:38 +0800
Subject: [PATCH v7 3/3] dts: arm64: Add mailbox binding for hi3660
In-Reply-To: <1521130058-24796-1-git-send-email-leo.yan@linaro.org>
References: <1521130058-24796-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1521130058-24796-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Add DT binding for mailbox driver.

Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 63d4f9d..3788448 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -298,6 +298,14 @@
 			#reset-cells = <2>;
 		};
 
+		mailbox: mailbox at e896b000 {
+			compatible = "hisilicon,hi3660-mbox";
+			reg = <0x0 0xe896b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <3>;
+		};
+
 		dual_timer0: timer at fff14000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x0 0xfff14000 0x0 0x1000>;
-- 
1.9.1
