From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 17:42:44 -0700
Subject: [PATCH v16 10/12] OMAP: dmtimer: extend spinlock in request
	functions
In-Reply-To: <1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110922004243.GL2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> The request functions now verify the success of omap_dm_timer_prepare() call
> after a timer is acquired. If *_prepare() fails then we have to release the
> timer. In order to avoid race condition during this time, include *_prepare()
> within lock.

This I've folded into patch 5.

Tony
