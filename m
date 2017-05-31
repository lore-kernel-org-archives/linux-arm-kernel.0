From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 31 May 2017 09:45:39 +0800
Subject: [Resend PATCH 2/2] arm64: dts: hi6220: add acpu_sctrl
In-Reply-To: <1496195139-16687-1-git-send-email-zhangfei.gao@linaro.org>
References: <1496195139-16687-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1496195139-16687-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add acpu_sctrl clock node

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
---
Verified on clk-next, v.12-rc1

 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 1e5129b..b3ecbcf 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -262,6 +262,12 @@
 			#clock-cells = <1>;
 		};
 
+		acpu_sctrl: acpu_sctrl at f7032000 {
+			compatible = "hisilicon,hi6220-acpu-sctrl", "syscon";
+			reg = <0x0 0xf6504000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		medianoc_ade: medianoc_ade at f4520000 {
 			compatible = "syscon";
 			reg = <0x0 0xf4520000 0x0 0x4000>;
-- 
2.7.4
