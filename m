From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 25 May 2017 16:18:51 +0800
Subject: [PATCH v2 09/12] arm64: dts: hi3660: Add pl031 rtc node
In-Reply-To: <20170525081854.4701-1-guodong.xu@linaro.org>
References: <20170525081854.4701-1-guodong.xu@linaro.org>
Message-ID: <20170525081854.4701-10-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Feng <puck.chen@hisilicon.com>

Add dts node to enable pl031 rtc.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 7a90c92..3b2a3a7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -326,6 +326,14 @@
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
