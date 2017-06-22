From: kevin.wangtao@hisilicon.com (Tao Wang)
Date: Thu, 22 Jun 2017 11:42:03 +0800
Subject: [Patch v2 3/3] arm64: dts: register Hi3660's thermal sensor
In-Reply-To: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Message-ID: <1498102923-68481-3-git-send-email-kevin.wangtao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bind thermal sensor driver for Hi3660.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
Changes in v2:
- rebase changes on linux next

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c6a1961..a6a1e01 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -848,5 +848,11 @@
 				     &sdio_cfg_func>;
 			status = "disabled";
 		};
+
+		tsensor: tsensor {
+			compatible = "hisilicon,hi3660-thermal";
+			reg = <0x0 0xfff30000 0x0 0x1000>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
-- 
1.7.9.5
