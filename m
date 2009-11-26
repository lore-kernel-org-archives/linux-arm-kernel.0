From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2009 10:50:02 +0000
Subject: [RESENT PATCH] Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091126105002.GB2393@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 11:26:04AM +0100, Uwe Kleine-K?nig wrote:
> These functions are called with irqs already off.
> 
> AT91RM2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> noone reporting having hit it.

Can we please start to create some documentation for this, even if it
just starts off as "these callbacks are always called with irqs
disabled" or some such thing.

I find the generic time stuff extremely difficult to work with, and I
suspect I'm not the only one.  This is probably why people like to be
sure by having their own IRQ disabling.
