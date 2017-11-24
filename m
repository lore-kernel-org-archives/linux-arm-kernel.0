From: yangbo.lu@nxp.com (Y.b. Lu)
Date: Fri, 24 Nov 2017 02:31:13 +0000
Subject: [PATCH] arm: dts: ls1021a: fix the value of TMR_FIPER1
In-Reply-To: <20171110015847.29635-1-yangbo.lu@nxp.com>
References: <20171110015847.29635-1-yangbo.lu@nxp.com>
Message-ID: <DB6PR0401MB2536A92B16A744BB51BA0197F8260@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comments?

+Shawn

Thanks.

-----Original Message-----
From: Yangbo Lu [mailto:yangbo.lu at nxp.com] 
Sent: 2017?11?10? 9:59
To: devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Russell King <linux@armlinux.org.uk>
Cc: Y.b. Lu <yangbo.lu@nxp.com>
Subject: [PATCH] arm: dts: ls1021a: fix the value of TMR_FIPER1

The timer fixed interval period pulse generator register is used to generate periodic pulses. The down count register loads the value programmed in the fixed period interval (FIPER). At every tick of the timer accumulator overflow, the counter decrements by the value of TMR_CTRL[TCLK_PERIOD]. It generates a pulse when the down counter value reaches zero. It reloads the down counter in the cycle following a pulse. To use the TMR_FIPER1 register to generate a 1 PPS event, the value
(10^9 nanoseconds) - TCLK_PERIOD should be programmed.
It should be 999999995 not 999999990 since TCLK_PERIOD is 5.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi index 9319e1f0f1d8..10e536f338f7 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -575,7 +575,7 @@
 			fsl,tclk-period = <5>;
 			fsl,tmr-prsc    = <2>;
 			fsl,tmr-add     = <0xaaaaaaab>;
-			fsl,tmr-fiper1  = <999999990>;
+			fsl,tmr-fiper1  = <999999995>;
 			fsl,tmr-fiper2  = <99990>;
 			fsl,max-adj     = <499999999>;
 		};
--
2.14.1
