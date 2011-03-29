From: khilman@ti.com (Kevin Hilman)
Date: Tue, 29 Mar 2011 11:16:23 -0700
Subject: [PATCH 00/10] omap init_early changes for irq and timer init
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:23 -0700")
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Message-ID: <87fwq5x05k.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> This series continues the work to only initialize minimal omap code
> in init_early and to cut down dependencies to code that should be
> initialized later. It also cleans up the omap2+ timer init code to prepare
> things for the later patches.
>
> After this series further patches can make the dmtimer code a regular
> device driver. Later on we can also move the clockource init happen 
> earlier to make sched_clock work properly with CONFIG_PRINTK_TIME.

This series looks OK to me.

My primary concerns were around the duplication of code between
early/system timers and the "real" device driver.  But it now looks like
those early timers will also be doing individual init using hwmod and
clock framework, so any duplication can be avoided.

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
