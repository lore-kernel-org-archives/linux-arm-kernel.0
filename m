From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 10 Feb 2014 15:26:51 -0500
Subject: [PATCH 2/2] ARM: keystone: dts: fix clkvcp3 control register address
In-Reply-To: <1392064011-11986-1-git-send-email-santosh.shilimkar@ti.com>
References: <1392064011-11986-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1392064011-11986-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

The address for control regs in clkvcp3 node is not correct and should
be 0x023500a8 instead of 0x0235000a8.

This lead to few unexpected behaviors while clocks were turned
of in absence of clk_ignore_unused

Mike Turquette <mturquette@linaro.org>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 2363593..ef58d1c 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -612,7 +612,7 @@ clocks {
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
 		clock-output-names = "vcp-3";
-		reg = <0x0235000a8 0xb00>, <0x02350060 0x400>;
+		reg = <0x023500a8 0xb00>, <0x02350060 0x400>;
 		reg-names = "control", "domain";
 		domain-id = <24>;
 	};
-- 
1.7.9.5
