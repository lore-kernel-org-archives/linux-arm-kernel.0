From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Fri, 21 Jun 2013 18:24:13 +0200
Subject: [PATCH] apf27dev: add rtc ds1374 to the device tree
Message-ID: <1371831853-24754-1-git-send-email-tremyfr@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
---
 arch/arm/boot/dts/imx27-apf27dev.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 66b8e1c..2a377ca 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -53,6 +53,11 @@
 &i2c1 {
 	clock-frequency = <400000>;
 	status = "okay";
+
+	rtc at 68 {
+		compatible = "dallas,ds1374";
+		reg = <0x68>;
+	};
 };
 
 &i2c2 {
-- 
1.7.4.4
