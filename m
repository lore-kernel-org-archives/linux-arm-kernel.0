From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:17 -0500
Subject: [PATCH v2 07/13] ARM: dts: vexpress: disable CA9 core tile sp804 timer
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The motherboard sp804 timer is used, but core tile sp804 timer is not.
According to Russell King, the clock configuration is undocumented and
defaults to 32kHz which is not desireable. So mark core tile sp804 timer
as disabled.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca9.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 1420bb1..62d9b22 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -98,6 +98,7 @@
 			     <0 49 4>;
 		clocks = <&oscclk2>, <&oscclk2>;
 		clock-names = "timclk", "apb_pclk";
+		status = "disabled";
 	};
 
 	watchdog at 100e5000 {
-- 
1.7.10.4
