From: balajitk@ti.com (Balaji T K)
Date: Mon, 26 Aug 2013 19:23:37 +0530
Subject: [PATCH 1/2] ARM: dts: dra7-evm: Add mmc1 node for micro-sd support
In-Reply-To: <1377525218-7655-1-git-send-email-balajitk@ti.com>
References: <1377525218-7655-1-git-send-email-balajitk@ti.com>
Message-ID: <1377525218-7655-2-git-send-email-balajitk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mmc1 dt node to dra7-evm board.
Input for ldo1 regulator is controlled by gpio 5 of pcf8575 chip (0x21)
on i2c1 bus. When dt support for gpio-pcf857x is available, input supply
will be modelled as cascaded regulator.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
Patch has dependency on [1] for ldo1_reg
[1] [PATCH] ARM: DTS: DRA7: Add TPS659038 PMIC nodes
https://lkml.org/lkml/2013/8/26/21

 arch/arm/boot/dts/dra7-evm.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 32f8534..a59bbd0 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -251,3 +251,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
+
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&ldo1_reg>;
+	bus-width = <4>;
+};
-- 
1.7.5.4
