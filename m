From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Sep 2011 11:12:46 +0300
Subject: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular
	board
In-Reply-To: <1314897912-18178-8-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-8-git-send-email-b-cousson@ti.com>
Message-ID: <20110902081246.GQ3548@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [110901 19:52]:
> In order to avoid conflict with the new board-omap3-dt.c file,
> remove the .dt_compat entry from the beagle regular board
> file.
> 
> Any DT work for OMAP3 will have to be done on the generic DT
> board file to avoid breaking the legacy board support until
> DT migration is done.

In general we should not keep duplicate old non-DT data around
now that we have the DT append support. Instead we should just
require the .dts file appended to zImage for all mach-omap2
machines. Otherwise we'll end up with double bloat :)

So it's OK to have the DT entries in board files so drivers
that get converted will work with them.

Tony
