From: kaloz@openwrt.org (Imre Kaloz)
Date: Wed, 20 May 2015 23:22:04 +0200
Subject: [PATCH] ARM: mvebu: armada-xp-linksys-mamba: Disable internal RTC
Message-ID: <1432156924-1030-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mamba (like the OpenBlocks AX3) doesn't have a crystal
connected to the internal RTC - let's prevent the kernel from
probing it.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Cc: <stable@vger.kernel.org> # v4.0 +
---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index a2cf215..fdd187c 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -95,6 +95,11 @@
 
 		internal-regs {
 
+			rtc at 10300 {
+				/* No crystal connected to the internal RTC */
+				status = "disabled";
+			};
+
 			/* J10: VCC, NC, RX, NC, TX, GND  */
 			serial at 12000 {
 				status = "okay";
-- 
2.1.0
