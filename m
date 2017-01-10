From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  9 Jan 2017 23:35:54 -0800
Subject: [PATCH v6 1/2] ARM: dts: vf610-zii-dev-rev-b: Remove leftover PWM
 pingroup
Message-ID: <20170110073555.12178-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove pwm0grp since it is:

	a) Not referenced anywhere in the DTS file (unlike Tower board it
	is based on, this board does not use/expose FTM0)

	b) Configures PTB2 and PTB3 in a way that contradicts
	pinctrl-mdio-mux

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Stefan Agner <stefan@agner.ch>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: andrew at lunn.ch
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: cphealy at gmail.com
Tested-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since v5:

	- Patchset rebased on 4.10-rc3


 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 958b4c4..c8e11a5 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -729,15 +729,6 @@
 		>;
 	};
 
-	pinctrl_pwm0: pwm0grp {
-		fsl,pins = <
-			VF610_PAD_PTB0__FTM0_CH0	0x1582
-			VF610_PAD_PTB1__FTM0_CH1	0x1582
-			VF610_PAD_PTB2__FTM0_CH2	0x1582
-			VF610_PAD_PTB3__FTM0_CH3	0x1582
-		>;
-	};
-
 	pinctrl_qspi0: qspi0grp {
 		fsl,pins = <
 			VF610_PAD_PTD7__QSPI0_B_QSCK	0x31c3
-- 
2.9.3
