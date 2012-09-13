From: marex@denx.de (Marek Vasut)
Date: Thu, 13 Sep 2012 13:23:22 +0200
Subject: [PATCH] ARM: dts: mxs: Add ethernetX to macX aliases
Message-ID: <1347535402-17148-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethernet0 and ethernet1 aliases into the imx28.dtsi file, as
that is what most bootloaders use to pass MAC address. The bootloader
seeks for this alias and adds "mac-address" and "local-mac-address"
properties to the aliased node. This fixes issues with FEC having
NULL MAC address when update_fec_mac_prop() wasn't called. And
not all boards call update_fec_mac_prop() .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 14ea47d..0e78d5b 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -27,6 +27,8 @@
 		serial2 = &auart2;
 		serial3 = &auart3;
 		serial4 = &auart4;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
 	};
 
 	cpus {
-- 
1.7.10.4
