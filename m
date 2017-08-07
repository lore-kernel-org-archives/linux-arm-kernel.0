From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Mon, 7 Aug 2017 17:19:15 +0800
Subject: [PATCH 2/2] dts: arm64: bind stub clock driver for Hi3660
In-Reply-To: <1502097555-11541-1-git-send-email-zhongkaihua@huawei.com>
References: <1502097555-11541-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1502097555-11541-2-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Add binding to stub clock driver.

Signed-off-by: Kai Zhao <zhaokai1@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Tested-by: Kaihua Zhong <zhongkaihua@huawei.com>

---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ac20065..f23df62 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -299,6 +299,14 @@
 			#mbox-cells = <3>;
 		};
 
+		stub_clock: stub_clock {
+			compatible = "hisilicon,hi3660-stub-clk";
+			reg = <0x0 0xe896b500 0x0 0x0100>;
+			#clock-cells = <1>;
+			mbox-names = "mbox-tx";
+			mboxes = <&mailbox 13 3 0>;
+		};
+
 		dual_timer0: timer at fff14000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x0 0xfff14000 0x0 0x1000>;
-- 
1.8.3.2
