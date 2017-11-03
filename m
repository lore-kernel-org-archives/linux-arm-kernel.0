From: zhongkaihua@huawei.com (Kaihua Zhong)
Date: Fri, 3 Nov 2017 15:25:07 +0800
Subject: [PATCH 3/3] arm64: dts: Hi3660: Add binding for stub clock
In-Reply-To: <1509693907-90682-1-git-send-email-zhongkaihua@huawei.com>
References: <1509693907-90682-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1509693907-90682-4-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding for Hi3660 stub clock driver.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kai Zhao <zhaokai1@hisilicon.com>
Signed-off-by: Kevin Wang <kevin.wangtao@hisilicon.com>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index b7a90d6..89a2a13 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -285,6 +285,14 @@
 			#reset-cells = <2>;
 		};
 
+		stub_clock: stub_clock {
+			compatible = "hisilicon,hi3660-stub-clk";
+			reg = <0x0 0xe896b500 0x0 0x0100>;
+			#clock-cells = <1>;
+			x-names = "mbox-tx";
+			xes = <&mailbox 13 3 0>;
+		};
+
 		dual_timer0: timer at fff14000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x0 0xfff14000 0x0 0x1000>;
-- 
1.9.1
