From: kevin.wangtao@hisilicon.com (Tao Wang)
Date: Tue, 20 Jun 2017 11:40:35 +0800
Subject: [PATCH 3/3] arm64: dts: register Hi3660's thermal sensor
In-Reply-To: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
Message-ID: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bind thermal sensor driver for Hi3660.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 3983086..cc67958 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -156,5 +156,12 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		tsensor: tsensor {
+			compatible = "hisilicon,thermal-hi3660";
+			reg = <0x0 0xfff30000 0x0 0x1000>;
+			#thermal-sensor-cells = <1>;
+			status = "ok";
+		};
 	};
 };
-- 
1.7.9.5
