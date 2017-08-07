From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Mon, 7 Aug 2017 17:17:13 +0800
Subject: [PATCH 2/3] dts: arm64: add mailbox binding for hi3660
In-Reply-To: <1502097434-11136-1-git-send-email-zhongkaihua@huawei.com>
References: <1502097434-11136-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1502097434-11136-2-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Add binding for mailbox driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Tested-by: Kaihua Zhong <zhongkaihua@huawei.com>

---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index eca984c..ac20065 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -291,6 +291,14 @@
 			#reset-cells = <2>;
 		};
 
+		mailbox: mailbox at e896b000 {
+			compatible = "hisilicon,hi3660-mbox";
+			reg = <0x0 0xe896b000 0x0 0x1000>;
+			interrupts = <0x0 0xc0 0x4>,
+			<0x0 0xc1 0x4>;
+			#mbox-cells = <3>;
+		};
+
 		dual_timer0: timer at fff14000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x0 0xfff14000 0x0 0x1000>;
-- 
1.8.3.2
