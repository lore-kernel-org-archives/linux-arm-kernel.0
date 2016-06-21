From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2016 04:28:59 -0700
Subject: [PATCH 1/2 v2] gpio: omap: make gpio numbering deterministical
 by using of aliases
In-Reply-To: <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160621112858.GO22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [160614 12:03]:
> Traditionally the n-th gpio device probed by the omap gpio driver got
> the gpio number range [n*32 .. n*32+31].
> When order of the devices probed by the driver changes (which can happen
> already now when some devices have a pinctrl and so the first probe
> attempt returns -ENODEV) the numbering changes.
> 
> To ensure a deterministical numbering use of_alias_get_id to determine
> the base for a given device. If no respective alias exists fall back to
> the traditional numbering.
> 
> For the unusual case where only a part of the gpio devices have a
> matching alias some of them might fail to probe. But if none of them has
> an alias or all, there is no conflict which should be good enough to
> maintain backward compatibility.

I think doing this is a good idea to prevent nasty suprises when
upgrading a kernel on some device:

Acked-by: Tony Lindgren <tony@atomide.com>
