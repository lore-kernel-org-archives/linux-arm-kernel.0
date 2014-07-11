From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 Jul 2014 16:44:38 -0500
Subject: [PATCHv2 05/10] ARM: dts: DRA7: Add mailbox nodes
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Message-ID: <1405115083-52977-6-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7xx has 13 system mailboxes, and is present on both the
DRA72x and DRA74x family of SoCs. Add the DT nodes for all
these 13 mailboxes. Except for mailbox 1, all other mailboxes
do not have interrupts mapped into the MPU GIC by default.

All the mailboxes have been disabled and the interrupts
property information is left out intentionally for now,
because of the dependencies against the crossbar driver.
These mailboxes can be enabled when a usecase arises
and the crossbar driver dependencies are met.

NOTE: The mailbox 1 has different number of mailbox fifos
and IP interrupts compared to the remaining 12 mailboxes.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 117 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c29945e..99c40d4 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -338,6 +338,123 @@
 			status = "disabled";
 		};
 
+		mailbox1: mailbox at 4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			ti,hwmods = "mailbox1";
+			ti,mbox-num-users = <3>;
+			ti,mbox-num-fifos = <8>;
+			status = "disabled";
+		};
+
+		mailbox2: mailbox at 4883a000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4883a000 0x200>;
+			ti,hwmods = "mailbox2";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox3: mailbox at 4883c000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4883c000 0x200>;
+			ti,hwmods = "mailbox3";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox4: mailbox at 4883e000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4883e000 0x200>;
+			ti,hwmods = "mailbox4";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox5: mailbox at 48840000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48840000 0x200>;
+			ti,hwmods = "mailbox5";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox6: mailbox at 48842000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48842000 0x200>;
+			ti,hwmods = "mailbox6";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox7: mailbox at 48844000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48844000 0x200>;
+			ti,hwmods = "mailbox7";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox8: mailbox at 48846000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48846000 0x200>;
+			ti,hwmods = "mailbox8";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox9: mailbox at 4885e000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4885e000 0x200>;
+			ti,hwmods = "mailbox9";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox10: mailbox at 48860000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48860000 0x200>;
+			ti,hwmods = "mailbox10";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox11: mailbox at 48862000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48862000 0x200>;
+			ti,hwmods = "mailbox11";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox12: mailbox at 48864000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48864000 0x200>;
+			ti,hwmods = "mailbox12";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
+		mailbox13: mailbox at 48802000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x48802000 0x200>;
+			ti,hwmods = "mailbox13";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <12>;
+			status = "disabled";
+		};
+
 		timer1: timer at 4ae18000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
-- 
2.0.0
