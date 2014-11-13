From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Nov 2014 10:31:43 +0100
Subject: [PATCH 1/7] ARM: dts: sunxi: Add regulator-boot-on property to
 ahci-5v regulator
Message-ID: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids it getting briefly turned off between when the regulator getting
registered and the ahci driver turning it back on, thus avoiding the disk
going into emergency head park mode.

Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
Reported-and-tested-by: Bruno Pr?mont <bonbons@linux-vserver.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index c9c5b10..a950671 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -44,6 +44,7 @@
 		regulator-name = "ahci-5v";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
 		enable-active-high;
 		gpio = <&pio 1 8 0>;
 		status = "disabled";
-- 
2.1.0
