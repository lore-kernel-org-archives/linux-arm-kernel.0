From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2011 00:54:30 -0700
Subject: [PATCH 08/10] omap2+: Use dmtimer macros for clocksource
In-Reply-To: <87iprwa2xx.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092345.357.11154.stgit@kaulin> <87iprwa2xx.fsf@ti.com>
Message-ID: <20110627075429.GF23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110623 10:06]:
> Tony Lindgren <tony@atomide.com> writes:
> > +
> > +	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
> 
> This function makes calls into "real" driver, but is called from
> sys_timer.init so happens before driver is initialized.

That one is the static omap2+ specific function that can be passed
to the dmtimer device driver as a function pointer in the later
patches. 
 
> > +	omap_dm_timer_set_load_start(&clksrc, 1, 0);
> 
> Here's another call into the real driver.  I think you need
> __omap_dm_timer_set_load_start() here.

Thanks, that's correct. Will fix that one.

Tony
