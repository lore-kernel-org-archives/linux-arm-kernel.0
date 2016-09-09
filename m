From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 9 Sep 2016 09:20:20 +0200
Subject: [PATCH v3] ARM: dts: add gpio-ranges property to iMX GPIO
 controllers
In-Reply-To: <1473386556-1934-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1473386556-1934-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <20160909072020.ieehalkgxxjfewhs@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 05:02:36AM +0300, Vladimir Zapolskiy wrote:
> To establish a connection between GPIO controllers and pin multiplexor
> controller add gpio-ranges properties to all GPIO controllers found
> on iMX50, iMX6Q/D, iMX6DL/S, iMX6SL, iMX6SX, iMX6UL and iMX7D/S
> SoCs. The change was done after human parsing of output from

When looking at doing the same for i.MX35 there are a few pin pairs that
are driven by the same GPIO, e.g.:

	$ grep GPIO3_9 imx35-pinfunc.h 
	#define MX35_PAD_CTS1__GPIO3_9					0x194 0x5d8 0x918 0x5 0x0
	#define MX35_PAD_FEC_COL__GPIO3_9				0x2ec 0x750 0x918 0x5 0x1

With this it's not possible to correctly add a gpio-ranges, right?

i.MX1, i.MX21, i.MX25, i.MX27 and i.MX53 could benefit from such a
change though. i.MX35 and i.MX51 have duplicates.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
