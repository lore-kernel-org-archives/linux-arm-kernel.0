From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 11:23:33 +0100
Subject: [PATCH 1/4] arm: mvebu: Reduce reg-io-width with UARTs
In-Reply-To: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362565416-15718-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Setting the reg-io-width to 1 byte represents more accurate
description of the HW.

This will fix an issue where UART driver causes kernel
panic during bootup. Gregory CLEMENT traced the issue to
autoconfig() in 8250.c, where the existence of FIFO is
checked from UART_IIR register. The register is now read as
32-bit value as the reg-io-width is set to 4-bytes. The
retuned value seems to contain bogus data for bits 31:8,
causing the issue.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    4 ++--
 arch/arm/boot/dts/armada-xp.dtsi     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6f1acc7..99afca4 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -54,7 +54,7 @@
 				reg = <0xd0012000 0x100>;
 				reg-shift = <2>;
 				interrupts = <41>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 		serial at d0012100 {
@@ -62,7 +62,7 @@
 				reg = <0xd0012100 0x100>;
 				reg-shift = <2>;
 				interrupts = <42>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 1443949..ca00d83 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -46,7 +46,7 @@
 				reg = <0xd0012200 0x100>;
 				reg-shift = <2>;
 				interrupts = <43>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 		serial at d0012300 {
@@ -54,7 +54,7 @@
 				reg = <0xd0012300 0x100>;
 				reg-shift = <2>;
 				interrupts = <44>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 
-- 
1.7.9.5
