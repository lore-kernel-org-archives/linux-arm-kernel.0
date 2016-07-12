From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Jul 2016 09:38:59 +0200
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
 <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
 <CAOMZO5A=6HLPacwp0seBn_s+AVF7zaUjUO8wOb1WoyvU1JrH7A@mail.gmail.com>
 <20160711073721.GM16643@pengutronix.de>
 <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
Message-ID: <20160712073859.GQ16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 07:56:15AM -0300, Fabio Estevam wrote:
> Hi Uwe,
> 
> On Mon, Jul 11, 2016 at 4:37 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> >> Then we could later change each 0x80000000 occurrance by replacing it
> >> with the actual PAD register value instead of the power on defaults.
> >
> > Why later?
> 
> I was not sure if you had access to all these mx25 boards to verify
> the real values used on the pin configurations. I don't have access to
> mx25pdk today, but I can access it later this week.

I don't have access to these, but I took a look in the U-boot sources.

So on top of my patch I'd suggest the following change:

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index cf41b726e2de..08caba550ee6 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -171,7 +171,7 @@
 			MX25_PAD_SD1_DATA2__SD1_DATA2		0x000000d1
 			MX25_PAD_SD1_DATA3__SD1_DATA3		0x000000d1
 			MX25_PAD_A14__GPIO_2_0			0x00000080
-			MX25_PAD_A15__GPIO_2_1			0x00000080
+			MX25_PAD_A15__GPIO_2_1			0x00000000
 		>;
 	};
 
@@ -187,14 +187,14 @@
 			MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x000000c0
 			MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x000001c0
 			MX25_PAD_A17__GPIO_2_3			0x00000000
-			MX25_PAD_D12__GPIO_4_8			0x000000a1
+			MX25_PAD_D12__GPIO_4_8			0x00000000
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX25_PAD_I2C1_CLK__I2C1_CLK		0x000000a8
-			MX25_PAD_I2C1_DAT__I2C1_DAT		0x000000a8
+			MX25_PAD_I2C1_CLK__I2C1_CLK		0x000001e8
+			MX25_PAD_I2C1_DAT__I2C1_DAT		0x000001e8
 		>;
 	};
 
Did I miss anything?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
