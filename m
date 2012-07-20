From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 20 Jul 2012 12:16:29 +0530
Subject: [PATCH 4/4] arm/dts: Add tps65217 regulator DT data to am335x-bone.dts
In-Reply-To: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Message-ID: <1342766789-28148-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds tps65217 regulator device tree data, which adds I2C node
with I2C frequency and tps65217 PMIC I2C slave address.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a9af4db..a4d4415 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,3 +18,13 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	tps: tps at 24 {
+		reg = <0x24>;
+	};
+};
+
+/include/ "tps65217.dtsi"
-- 
1.7.0.4
