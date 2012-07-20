From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 20 Jul 2012 12:16:28 +0530
Subject: [PATCH 3/4] arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
In-Reply-To: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Message-ID: <1342766789-28148-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds tps65910 regulator device tree data, which adds I2C node
with I2C frequency and tps65910 PMIC I2C slave address.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d6a97d9..15d03ba 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -18,3 +18,13 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	tps: tps at 2D {
+		reg = <0x2D>;
+	};
+};
+
+/include/ "tps65910.dtsi"
-- 
1.7.0.4
