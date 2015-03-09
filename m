From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  9 Mar 2015 21:06:56 +0100
Subject: [PATCH 3/4] ARM: shmobile: lager dts: Add da9210 regulator interrupt
In-Reply-To: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
References: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1425931617-5479-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da9210 regulator is connected to IRQ2. Reflect this in its device
node, so the driver can use it when it gains interrupt support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 329bb994aac04084..6fa8681a431fceb8 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -585,6 +585,8 @@
 	vdd_dvfs: regulator at 68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 
 		regulator-min-microvolt = <1000000>;
 		regulator-max-microvolt = <1000000>;
-- 
1.9.1
