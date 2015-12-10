From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Dec 2015 15:21:13 -0600
Subject: [PATCH 3/3] arm64: dts: hikey: add label properties to UARTs
In-Reply-To: <1449782473-20880-1-git-send-email-robh@kernel.org>
References: <1449782473-20880-1-git-send-email-robh@kernel.org>
Message-ID: <1449782473-20880-4-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add label properties to provide a way to identify UARTs based on their
board or connector name. This follows naming convention in 96boards CE
spec. Ports without external connections are not labelled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 8d43a0f..8185251 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -32,3 +32,10 @@
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 };
+
+&uart2 {
+	label = "LS-UART0";
+};
+&uart3 {
+	label = "LS-UART1";
+};
-- 
2.5.0
