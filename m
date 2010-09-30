From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Sep 2010 08:07:13 -0700
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
In-Reply-To: <4CA49ADE.6080202@ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com>
Message-ID: <20100930150713.GG3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [100930 07:04]:
> 
> I think that disabling it should be done only if the CONFIG_OMAP_WDT
> is not set.

How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
is set? That way product kernels can set CONFIG_WATCHDOG_NOWAYOUT
and for the rest of us we can let fsck run the standard Linux way.

Tony
