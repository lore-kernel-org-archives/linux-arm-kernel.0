From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 20 Mar 2011 22:30:45 +0100
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <Pine.LNX.4.64.1103202143070.27008@ask.diku.dk>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
	<Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
	<20110320192451.GA19808@pengutronix.de>
	<Pine.LNX.4.64.1103202143070.27008@ask.diku.dk>
Message-ID: <20110320213045.GA27943@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 20, 2011 at 09:51:32PM +0100, Julia Lawall wrote:
> I guess that the !GPIOLIB issue is related to a configuration option, that 
> can't very easily be detected from looking at the C file alone?

Yes, that is a configuration option at the moment. It shouldn't be IMO, that's
what my patch is addressing.

> Ignoring that issue, the following semantic patch addresses the common 

Sigh, here goes my chance to play with coccinelle again ;)

> case where there is no error checking for the input or output call, but 
> there may be error checking for the gpio_request call.  This transforms 
> over 500 occurrences.

In my book, converting the ones which do not check errors at all is not worth
the trouble. Proper error-checking should be the main benefit, not one saved
line. So, this is mindwork. If gpio_request is checked, merging seems sensible
(but should be audited).

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110320/a9fbf2da/attachment.sig>
