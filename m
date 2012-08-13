From: sourav.poddar@ti.com (Sourav Poddar)
Date: Mon, 13 Aug 2012 15:58:55 +0530
Subject: [PATCHv2 4/4] arm/dts: omap5-evm: Add bmp085 sensor support
In-Reply-To: <1344853735-16313-1-git-send-email-sourav.poddar@ti.com>
References: <1344853735-16313-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <1344853735-16313-2-git-send-email-sourav.poddar@ti.com>
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
 arch/arm/boot/dts/omap5-evm.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index c2ea189..18e499c 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -39,3 +39,12 @@
 		reg = <0x48>;
 	};
 };
+
+&i2c2 {
+	clock-frequency = <400000>;
+
+	bmp085 at 77 {
+		compatible = "bosch,bmp085";
+		reg = <0x77>;
+	};
+};
-- 
1.7.1
