From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 15:22:24 -0700
Subject: [PATCH 08/10] ARM: OMAP: Clean-up timer posted mode support
In-Reply-To: <1346871872-24413-9-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
 <1346871872-24413-9-git-send-email-jon-hunter@ti.com>
Message-ID: <20120907222223.GQ1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120905 12:05]:
> The dmtimer functions to read and write the dmtimer registers are currently
> defined as follows ...
> 
> static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
> 						int posted);
> static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
> 						u32 reg, u32 val, int posted);
> 
> The posted variable indicates if the timer is configured to use the posted mode
> when performing register accesses. The posted mode configuration of the dmtimer
> is stored in the omap_dm_timer structure that is also being passed to the above
> functions and therefore we do not need to pass the posted variable separately.
> Therefore, simplify the above functions by removing the posted variable as an
> argument as this is not necessary.

I believe the reason for passing the posted flag was to optimize out some
functions from the timer code as that's being run all the time.

Care to check the assembly before and after this patch for the timer
functions with objdump -d to make sure it does not add tons of bloat
there?

Thanks,

Tony
