From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 28 Feb 2018 12:54:55 +0800
Subject: [PATCH v6 3/3] dts: arm64: Add mailbox binding for hi3660
In-Reply-To: <1519793695-20198-1-git-send-email-leo.yan@linaro.org>
References: <1519793695-20198-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1519793695-20198-4-git-send-email-leo.yan@linaro.org>
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
index dc00392..55907e0 100644
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
 		stub_clock: stub_clock at e896b500 {
 			compatible = "hisilicon,hi3660-stub-clk";
 			reg = <0x0 0xe896b500 0x0 0x0100>;
-- 
1.9.1
