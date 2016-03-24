From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Mar 2016 09:14:13 +0100
Subject: [PATCH 0/4] serial: imx: some irq and handshaking fixes
In-Reply-To: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160324081413.GR6191@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

On Thu, Mar 10, 2016 at 11:26:05AM +0100, Uwe Kleine-K?nig wrote:
> this series doesn't solve all my problems but at least some. Now for my
> remaining problem my machine at least doesn't reset (by watchdog) but
> disables the serial irq instead which at least allows to debug further.
> (Still I'm a bit out of ideas.)
> 
> The last patch doesn't fix a real problem I have, just noticed that
> while working on the handshaking stuff.
> 
> It would be great if these patched made it into v4.6-rc1.

I have to rework this series. There is an unclear situation that results
in a stuck irq on i.MX25 because I'm unable to clear the DCD irq. Also I
missed a hunk in "let irq handler return IRQ_NONE if no event was
handled".

I will post a safer series later today. Please don't apply this one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
