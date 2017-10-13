From: peda@axentia.se (Peter Rosin)
Date: Fri, 13 Oct 2017 11:27:05 +0200
Subject: [PATCH 2/2] ARM: dts: at91: disable the nxp,
 se97b SMBUS timeout on the TSE-850
In-Reply-To: <20171013092705.7038-1-peda@axentia.se>
References: <20171013092705.7038-1-peda@axentia.se>
Message-ID: <20171013092705.7038-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C adapter driver is sometimes slow, causing the SCL line to
be stuck low for more than the stipulated SMBUS timeout of 25-35 ms.
This causes the client device to give up which in turn causes silent
corruption of data. So, disable the SMBUS timeout in the client device.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-tse850-3.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 5f29010cdbd8..9b82cc8843e1 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -221,6 +221,7 @@
 	jc42 at 18 {
 		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
 		reg = <0x18>;
+		smbus-timeout-disable;
 	};
 
 	dpot: mcp4651-104 at 28 {
-- 
2.11.0
