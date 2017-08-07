From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 16:13:24 +0800
Subject: [PATCH 6/7] arm64: dts: hikey960: Add pstore support
In-Reply-To: <20170807081325.11406-1-guodong.xu@linaro.org>
References: <20170807081325.11406-1-guodong.xu@linaro.org>
Message-ID: <20170807081325.11406-7-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reserves some memory in the DTS and sets up a
pstore device tree node to enable pstore support on HiKey960.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index ce5e874..7770ec7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -39,6 +39,20 @@
 		reg = <0x0 0x0 0x0 0x0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops at 32000000 {
+			compatible = "ramoops";
+			reg = <0x0 0x32000000 0x0 0x00100000>;
+			record-size	= <0x00020000>;
+			console-size	= <0x00020000>;
+			ftrace-size	= <0x00020000>;
+		};
+	};
+
 	reboot-mode-syscon at 32100000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0x0 0x32100000 0x0 0x00001000>;
-- 
2.10.2
