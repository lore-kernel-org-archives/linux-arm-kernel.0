From: steven.lin1@broadcom.com (Steve Lin)
Date: Wed, 22 Feb 2017 16:22:23 -0500
Subject: [PATCH 1/1] ARM: dts: NSP: Add crypto (SPU) to dtsi
Message-ID: <1487798543-34229-1-git-send-email-steven.lin1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds crypto hardware (SPU) to Northstar Plus device tree file.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>

---
Code changes for this addition were submitted previously by Rob
Rice: https://git.kernel.org/cgit/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=9d12ba86f818aa9cfe9f01b750336aa441f2ffa2
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index b6142bd..9bac0c8 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -241,6 +241,12 @@
 			brcm,nand-has-wp;
 		};
 
+		crypto at 2f000 {
+			compatible = "brcm,spum-nsp-crypto";
+			reg = <0x2f000 0x900>;
+			mboxes = <&mailbox 0>;
+		};
+
 		gpiob: gpio at 30000 {
 			compatible = "brcm,iproc-nsp-gpio", "brcm,iproc-gpio";
 			reg = <0x30000 0x50>;
-- 
2.1.0
