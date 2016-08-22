From: john.stultz@linaro.org (John Stultz)
Date: Mon, 22 Aug 2016 15:48:03 -0700
Subject: [PATCH 2/4] arm64: dts: Add HDMI node for hi6220-hikey
In-Reply-To: <1471906085-16682-1-git-send-email-john.stultz@linaro.org>
References: <1471906085-16682-1-git-send-email-john.stultz@linaro.org>
Message-ID: <1471906085-16682-2-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xinliang Liu <xinliang.liu@linaro.org>

Add adv7533 HDMI DT node for HiKey board.

Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index c2f014e..8597e9b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -379,4 +379,36 @@
 
 &dsi {
 	status = "ok";
+
+	ports {
+		/* 1 for output port */
+		port at 1 {
+			reg = <1>;
+
+			dsi_out0: endpoint at 0 {
+				remote-endpoint = <&adv7533_in>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "ok";
+
+	adv7533: adv7533 at 39 {
+		compatible = "adi,adv7533";
+		reg = <0x39>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 2>;
+		pd-gpio = <&gpio0 4 0>;
+		adi,dsi-lanes = <4>;
+
+		port {
+			adv7533_in: endpoint {
+				remote-endpoint = <&dsi_out0>;
+			};
+		};
+	};
 };
-- 
1.9.1
