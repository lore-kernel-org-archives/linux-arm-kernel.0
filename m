From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Mon, 30 May 2016 18:39:42 +0200
Subject: [PATCH 2/5] arm/dts/imx6q-b850v3: Configure IPU assignment order
In-Reply-To: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
Message-ID: <1464626385-19253-3-git-send-email-peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the IPU assignment order to assign one IPU per external
display. A single IPU can drive multiple external displays but there are
resolution restrictions. After this patch the GPU is capalbe of driving two
Full-HD monitors.

Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
 arch/arm/boot/dts/imx6q-b850v3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 167f744..88a70de 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -51,6 +51,11 @@
 	chosen {
 		stdout-path = &uart3;
 	};
+
+	display-subsystem {
+		compatible = "fsl,imx-display-subsystem";
+		ports = <&ipu1_di0>, <&ipu2_di0>, <&ipu1_di1>, <&ipu2_di1>;
+	};
 };
 
 &clks {
-- 
2.5.5
