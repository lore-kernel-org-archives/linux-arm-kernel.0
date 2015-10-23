From: ats@offog.org (Adam Sampson)
Date: Fri, 23 Oct 2015 23:36:27 +0100
Subject: [PATCH] ARM: sun7i: dt: Enable audio codec on pcDuino V3 Nano
Message-ID: <1445639787-23715-1-git-send-email-ats@offog.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcDuino V3 Nano has a 3.5mm TRRS jack socket for audio, using the
CTIA standard pinout, connected to HPOUTL, HPOUTR, HPCOM/HPCOMFB and
MICIN1/VMIC (via appropriate RC networks) on the A20. The PH00 GPIO is
wired for headphone plug detection: it reads 0 when nothing's plugged
in, and 1 when a plug is inserted.

LINEINL/R and FMINL/R are not connected.

Signed-off-by: Adam Sampson <ats@offog.org>
---
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index 1757a6a..ddac732 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -82,6 +82,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
-- 
2.1.4
