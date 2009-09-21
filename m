From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 10:04:00 +0100
Subject: [PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20090921090400.GD27357@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 09:39:22AM +0200, Uwe Kleine-K?nig wrote:
> These functions are called with irqs already off.
> 
> at91rm2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> noone reporting having hit it.

It might be useful to document these clockevent interfaces.  There's
at least a few ARM clockevent implementations which don't set the
periodic interval when set_next_event() is called - probably because
it wasn't realised that it was required.
