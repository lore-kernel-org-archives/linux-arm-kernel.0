From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Apr 2014 10:00:41 +0200
Subject: [PATCH] ARM: fix v7-M setup stack location
In-Reply-To: <1398103637-22828-1-git-send-email-rabin@rab.in>
References: <1398103637-22828-1-git-send-email-rabin@rab.in>
Message-ID: <20140428080041.GC28564@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 21, 2014 at 08:07:17PM +0200, Rabin Vincent wrote:
> __v7m_setup_stack currently sits in the .proc.info.init section, and
> thus creates a bogus proc info entry (which by the way matches any
> unknown CPU IDs, due to the entry's mask being 0).  Move it out of
> there.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

It seems the unpatched code didn't do any harm as long as you boot the
resulting kernel on a v7-M machine. So I'd say it's not a very urgent
fix and getting it in during the next merge window is just fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
