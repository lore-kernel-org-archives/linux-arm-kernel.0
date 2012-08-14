From: sourav.poddar@ti.com (Sourav Poddar)
Date: Tue, 14 Aug 2012 21:54:33 +0530
Subject: [PATCHv3 4/4] arm/dts: omap5-evm: Add bmp085 sensor support
In-Reply-To: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
References: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <1344961473-13675-5-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bmp085 pressure sensor data in omap5 evm dts file.

Tested on omap5430 evm with 3.5 custom kernel.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 8835026..378ccc2 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -40,3 +40,13 @@
 		reg = <0x48>;
 	};
 };
+
+&i2c2 {
+	clock-frequency = <400000>;
+
+	/* Pressure Sensor */
+	bmp085 at 77 {
+		compatible = "bosch,bmp085";
+		reg = <0x77>;
+	};
+};
-- 
1.7.1
