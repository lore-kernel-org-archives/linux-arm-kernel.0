From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 20 Nov 2014 20:14:37 +0000
Subject: [PATCH RFC 3/3] ARM: dts: enable power subsystem for i.MX28
In-Reply-To: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1416514477-19190-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the power subsystem for all i.MX28 boards.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28.dtsi |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 47f68ac..5c163a5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1022,8 +1022,12 @@
 			};

 			power: power at 80044000 {
+				compatible = "fsl,imx28-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <6>;
+				ranges;
 			};

 			saif1: saif at 80046000 {
--
1.7.9.5
