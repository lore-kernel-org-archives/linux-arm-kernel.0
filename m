From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 18 Sep 2014 20:15:24 +0300
Subject: [PATCH 3/3] ARM: dts: keystone: k2l: Fix chip selects for SPI devices
In-Reply-To: <1411060524-25077-1-git-send-email-grygorii.strashko@ti.com>
References: <1411060524-25077-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1411060524-25077-4-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

There are 5 chip selects per SPI0 and SPI2 and 3 per SPI1. SPI2 needs
to be pinned out to use and by default they are disabled. So keep the
state disabled to reflect default.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2l.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/k2l.dtsi b/arch/arm/boot/dts/k2l.dtsi
index e3bb142..291db43 100644
--- a/arch/arm/boot/dts/k2l.dtsi
+++ b/arch/arm/boot/dts/k2l.dtsi
@@ -81,3 +81,17 @@
 		};
 	};
 };
+
+&spi0 {
+       ti,davinci-spi-num-cs = <5>;
+};
+
+&spi1 {
+       ti,davinci-spi-num-cs = <3>;
+};
+
+&spi2 {
+       ti,davinci-spi-num-cs = <5>;
+       /* Pin muxed. Enabled and configured by Bootloader */
+       status = "disabled";
+};
-- 
1.9.1
