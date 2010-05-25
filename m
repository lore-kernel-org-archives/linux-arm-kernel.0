From: wim@iguana.be (Wim Van Sebroeck)
Date: Tue, 25 May 2010 13:06:44 +0200
Subject: [PATCH 1/6] Driver for the watchdog timer on Freescale IMX2
	(and later) processors.
In-Reply-To: <20100525102629.GB25521@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-2-git-send-email-w.sang@pengutronix.de>
	<20100514024915.GE30794@pengutronix.de>
	<20100521215211.GV3972@infomag.iguana.be>
	<20100525091840.GA25521@pengutronix.de>
	<20100525101233.GY3972@infomag.iguana.be>
	<20100525102629.GB25521@pengutronix.de>
Message-ID: <20100525110644.GA3972@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> > > > #define WDOG_SEC_TO_COUNT(s)	((s * 2) << 8)
> > > 
> > > Any reason you dropped the '- 1' from my version here?
> > 
> > If you want a timeout of 1 second, and you subtract the -1 then you only get
> > 0.5 seconds according to the reference manual.
> 
> Which one? MX27 and MX31 refman say the range is 0.5 to 128 seconds.
> So, 0x00 = 0.5s, 0x01 = 1.0s... The MX35 refman even has a table confirming this.

My fault. I interpreted it incorrectly. if you have 128 seconds then you indeed have value 0xFF << 8...
so -1 should indeed be there. This make the macro:
#define WDOG_SEC_TO_COUNT(s)	(((s * 2) - 1) << 8)

Thanks,
Wim.
