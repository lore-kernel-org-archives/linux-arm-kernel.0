From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 18 Nov 2017 14:04:13 +0100
Subject: [PATCH 2/2] ARM: bcm283x: Add missing interrupt for RNG block
In-Reply-To: <1511010253-5006-1-git-send-email-stefan.wahren@i2se.com>
References: <1511010253-5006-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1511010253-5006-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing interrupt property to the RNG block
of BCM283x.

Link: https://github.com/raspberrypi/linux/issues/2195
CC: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 013431e..0c17a81 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -135,6 +135,7 @@
 		rng at 7e104000 {
 			compatible = "brcm,bcm2835-rng";
 			reg = <0x7e104000 0x10>;
+			interrupts = <2 29>;
 		};
 
 		mailbox: mailbox at 7e00b880 {
-- 
2.7.4
