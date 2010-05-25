From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 25 May 2010 12:26:29 +0200
Subject: [PATCH 1/6] Driver for the watchdog timer on Freescale IMX2
	(and later) processors.
In-Reply-To: <20100525101233.GY3972@infomag.iguana.be>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-2-git-send-email-w.sang@pengutronix.de>
	<20100514024915.GE30794@pengutronix.de>
	<20100521215211.GV3972@infomag.iguana.be>
	<20100525091840.GA25521@pengutronix.de>
	<20100525101233.GY3972@infomag.iguana.be>
Message-ID: <20100525102629.GB25521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > * the code is ready for when we change to the generic watchdog api.
> > 
> > Cool, any concrete plans for this happening?
> 
> I'm reviewing it with Alan, we discussed some smaal changes. Once they are
> applied, Alan will review the code again. After that we will sent it out for
> review on the mailing-lists. So I expect within 2 weeks.

Awesome news! \o/

> > The new driver-rule should apply here, no?
> 
> Normally yes, but this should have been reviewed earlier by myself. If we
> have something working and after all the reviews we allready did, I think it
	> is time that user's can start using this watchdog.

Uhm, yes, but they can still have it with rc2? Doesn't matter, the sooner the
better ;)

> > > #define WDOG_SEC_TO_COUNT(s)	((s * 2) << 8)
> > 
> > Any reason you dropped the '- 1' from my version here?
> 
> If you want a timeout of 1 second, and you subtract the -1 then you only get
> 0.5 seconds according to the reference manual.

Which one? MX27 and MX31 refman say the range is 0.5 to 128 seconds.
So, 0x00 = 0.5s, 0x01 = 1.0s... The MX35 refman even has a table confirming this.

> > This is too excessive IMO. The bootloader might already have setup the
> > watchdog according to the board.
> 
> imho timeout should be set, watchdog should reset and not generate an
> interrupt and WDE bit should be used. All the rest should indeed be set by a
> boot-loader.

ACK.

> Will sent you the changed code and a test-program (so that I can see what the
> output is :-) ).

Okay.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100525/18dff0a8/attachment.sig>
