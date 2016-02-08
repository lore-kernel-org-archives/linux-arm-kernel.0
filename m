From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:16:09 +0100
Subject: [PATCH 4/6] ARM: dts: alpine: add the MSIX node
In-Reply-To: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1454922971-17405-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the newly available MSIX driver for Alpine, add the corresponding
node in the Alpine device tree.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/alpine.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 9af2d60e9a7f..db8752fc480e 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -155,6 +155,16 @@
 			ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
 
 			bus-range = <0x00 0x00>;
+			msi-parent = <&msix>;
+		};
+
+		msix: msix at fbe00000 {
+			compatible = "al,alpine-msix";
+			reg = <0x0 0xfbe00000 0x0 0x100000>;
+			interrupt-controller;
+			msi-controller;
+			al,msi-base-spi = <96>;
+			al,msi-num-spis = <64>;
 		};
 	};
 };
-- 
2.7.0
