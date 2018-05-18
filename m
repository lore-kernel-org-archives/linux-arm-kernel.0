From: aford173@gmail.com (Adam Ford)
Date: Fri, 18 May 2018 15:43:39 -0500
Subject: [PATCH] ARM: dts: da850-evm: Enable SATA port
Message-ID: <20180518204339.14298-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DA850-EVM from Logic PD has a SATA port and the module that went
with the kit support it as well. This patch will enable the SATA
controller.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index a76c2ddfd23e..afccbe7681e7 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -160,6 +160,10 @@
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
-- 
2.17.0
