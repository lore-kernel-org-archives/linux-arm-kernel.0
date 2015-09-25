From: marek@goldelico.com (Marek Belisko)
Date: Fri, 25 Sep 2015 22:20:47 +0200
Subject: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
In-Reply-To: <1443212447-5841-1-git-send-email-marek@goldelico.com>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
Message-ID: <1443212447-5841-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added new iio properties which are required for twl4030-charger driver and
allow to use twl4030-madc indirectly.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/twl4030.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 36ae916..482b7aa 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -22,6 +22,8 @@
 	charger: bci {
 		compatible = "ti,twl4030-bci";
 		interrupts = <9>, <2>;
+		io-channels = <&twl4030_madc 11>;
+		io-channel-name = "vac";
 		bci3v1-supply = <&vusb3v1>;
 	};
 
-- 
1.9.1
