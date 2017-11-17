From: xuyiping@hisilicon.com (Xu YiPing)
Date: Fri, 17 Nov 2017 17:27:32 +0800
Subject: [PATCH v3 3/3] arm64: dts: Hi3660: Add binding for stub clock
In-Reply-To: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
References: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
Message-ID: <1510910852-2175-4-git-send-email-xuyiping@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Add DT binding for Hi3660 stub clock driver.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kai Zhao <zhaokai1@hisilicon.com>
Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 451b6bf..cbbc7f1 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -293,6 +293,13 @@
 			#mbox-cells = <3>;
 		};
 
+		stub_clock: stub_clock at e896b500 {
+			compatible = "hisilicon,hi3660-stub-clk";
+			reg = <0x0 0xe896b500 0x0 0x0100>;
+			#clock-cells = <1>;
+			mboxes = <&mailbox 13 3 0>;
+		};
+
 		dual_timer0: timer at fff14000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x0 0xfff14000 0x0 0x1000>;
-- 
1.9.1
