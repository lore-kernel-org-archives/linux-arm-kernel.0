From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:16:08 +0100
Subject: [PATCH 3/6] arm64: dts: alpine: add the MSIX node in the Alpine v2
 dtsi
In-Reply-To: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1454922971-17405-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the addition of the Alpine MSIX controller driver, add the
corresponding node in the Alpine v2 device tree.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm64/boot/dts/al/alpine-v2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/al/alpine-v2.dtsi
index eb7a03b71456..413062be1674 100644
--- a/arch/arm64/boot/dts/al/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/al/alpine-v2.dtsi
@@ -141,6 +141,16 @@
 			/* 32 bit non prefetchable memory space */
 			ranges = <0x2000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
 			bus-range = <0x00 0x00>;
+			msi-parent = <&msix>;
+		};
+
+		msix: msix at fbe00000 {
+			compatible = "al,alpine-msix";
+			reg = <0x0 0xfbe00000 0x0 0x100000>;
+			interrupt-controller;
+			msi-controller;
+			al,msi-base-spi = <160>;
+			al,msi-num-spis = <160>;
 		};
 
 		uart0: uart at fd883000 {
-- 
2.7.0
