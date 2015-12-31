From: v1ron@mail.ru (Roman Volkov)
Date: Thu, 31 Dec 2015 20:41:17 +0300
Subject: [PATCH v3 RESEND 1/2] dts: vt8500: Add SDHC node to DTS file for
 WM8650
In-Reply-To: <1451583678-3692-1-git-send-email-v1ron@mail.ru>
References: <1451583678-3692-1-git-send-email-v1ron@mail.ru>
Message-ID: <1451583678-3692-2-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

Since WM8650 has the same 'WMT' SDHC controller as WM8505, and the driver
is already in the kernel, this node enables the controller support for
WM8650

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
Reviewed-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index b1c59a7..e12213d 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -187,6 +187,15 @@
 			interrupts = <43>;
 		};
 
+		sdhc at d800a000 {
+			compatible = "wm,wm8505-sdhc";
+			reg = <0xd800a000 0x400>;
+			interrupts = <20>, <21>;
+			clocks = <&clksdhc>;
+			bus-width = <4>;
+			sdon-inverted;
+		};
+
 		fb: fb at d8050800 {
 			compatible = "wm,wm8505-fb";
 			reg = <0xd8050800 0x200>;
-- 
2.3.1
