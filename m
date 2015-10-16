From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 16 Oct 2015 08:21:31 +0100
Subject: [PATCH v4 5/5] ARM: STi: DT: STiH407: Enable Mailbox testing facility
In-Reply-To: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
References: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1444980091-16728-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies a Client node to enable the Mailbox testing
facility.  It will be used to send and receive messages from any
given co-processor in order to test the STi Mailbox Controller
driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 0e5d3ea..e6c8243 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -611,6 +611,12 @@
 			st,pwm-num-chan = <4>;
 		};
 
+		mailbox_test {
+			compatible = "mailbox_test";
+			mboxes = <&mailbox2 1 31>, <&mailbox0 1 31>;
+			mbox-names = "tx", "rx";
+		};
+
 		mailbox0: mailbox at 0  {
 			compatible	= "st,stih407-mailbox";
 			reg		= <0x8f00000 0x1000>;
-- 
1.9.1
