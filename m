From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 17 May 2017 16:37:42 +0800
Subject: [PATCH 09/12] arm64: dts: hi3660: Add pl031 rtc node
In-Reply-To: <20170517083745.24479-1-guodong.xu@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
Message-ID: <20170517083745.24479-10-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Feng <puck.chen@hisilicon.com>

Add dts node to enable pl031 rtc.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 0951a29..c2bca5d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -312,6 +312,14 @@
 			status = "disabled";
 		};
 
+		rtc0: rtc at fff04000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x0 0Xfff04000 0x0 0x1000>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+		};
+
 		gpio0: gpio at e8a0b000 {
 			compatible = "arm,pl061", "arm,primecell";
 			reg = <0 0xe8a0b000 0 0x1000>;
-- 
2.10.2
