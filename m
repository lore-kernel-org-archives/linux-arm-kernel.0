From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 24 Oct 2018 00:36:54 +0530
Subject: [PATCH 4/5] arm64: boot: dts: hisilicon: hikey970: Enable on-board
 UARTs
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181023190655.12004-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable on-board UARTs on HiSilicon HiKey970 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 8fdc1dfcb06c..fc851a3177e7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -17,6 +17,12 @@
 	compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
 
 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
 		serial6 = &uart6;       /* console UART */
 	};
 
@@ -31,6 +37,20 @@
 	};
 };
 
+&uart0 {
+	/* On High speed expansion header */
+	label = "HS-UART0";
+	status = "okay";
+};
+
+&uart2 {
+	/* On Low speed expansion header */
+	label = "LS-UART0";
+	status = "okay";
+};
+
 &uart6 {
+	/* On Low speed expansion header */
+	label = "LS-UART1";
 	status = "okay";
 };
-- 
2.17.1
