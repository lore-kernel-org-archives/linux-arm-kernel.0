From: balajitk@ti.com (Balaji T K)
Date: Mon, 7 Oct 2013 21:55:03 +0530
Subject: [PATCH v2 1/2] ARM: dts: dra7-evm: Add mmc1 node for micro-sd support
Message-ID: <1381163104-6318-1-git-send-email-balajitk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mmc1 dt node to dra7-evm board.
Input for ldo1 regulator is controlled by gpio 5 of pcf8575 chip (0x21)
on i2c1 bus. When dt support for gpio-pcf857x is available, input supply
will be modelled as cascaded regulator.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
Rebase to for_3.13/dts

 arch/arm/boot/dts/dra7-evm.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index fbbe406..65cd15a 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -250,3 +250,9 @@
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
