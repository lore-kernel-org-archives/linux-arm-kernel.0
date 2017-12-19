From: zhongkaihua@huawei.com (Kaihua Zhong)
Date: Tue, 19 Dec 2017 19:15:45 +0800
Subject: [PATCH v4 3/3] dts: arm64: Add mailbox binding for hi3660
In-Reply-To: <1513682145-19892-1-git-send-email-zhongkaihua@huawei.com>
References: <1513682145-19892-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1513682145-19892-4-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding for mailbox driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 22570c3..1ef7b94 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -286,6 +286,14 @@
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
