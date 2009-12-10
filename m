From: david-b@pacbell.net (David Brownell)
Date: Thu, 10 Dec 2009 13:01:24 -0800
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <87pr6mww1d.fsf@free.fr>
References: <Pine.LNX.4.44L0.0912061458540.7903-100000@netrider.rowland.org>
	<200912061223.00528.david-b@pacbell.net> <87pr6mww1d.fsf@free.fr>
Message-ID: <200912101301.24839.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> As a side note, from a very quick glance at pxa25x_udc and omap_udc, I'm a bit
> surprised they didn't suffer from the same behaviour.

Haven't touched either of those drivers in years.  But a really
quick glance shows pxa25x_udc::done() setting a "stopped" flag,
and omap_udc::done() doing the same, before calling out to the
completion callback.

- Dave
