From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Sep 2012 23:55:33 +0000 (UTC)
Subject: [PATCH V2 3/7] ARM: OMAP4: Add timer clock aliases for device-tree
In-Reply-To: <1347579091-3794-4-git-send-email-jon-hunter@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <1347579091-3794-4-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1209192355220.14850@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Sep 2012, Jon Hunter wrote:

> For OMAP4, the dmtimers are located in the Wake-up, ABE and Peripheral (PER)
> power domains. Hence, when the dmtimer is configured to use the "timer_sys_ck"
> as its functional clock the actual clock used is different depending on whether
> the clock is in the Wake-up, ABE or PER domain. So when we look-up the dmtimer's
> "timer_sys_ck" we need to specify the timer device name as well as clock alias
> to find the right clock.
> 
> Currently, the device names for the timers have the format "omap_timer.X" where
> X is the timer instance number. When using to device tree, the format of the
> device name created by device-tree is different and has the format
> "<reg-address>.<device-name>" (this is assuming that the device-tree "reg"
> property is specified). This causes the look-up for the OMAP4 "timer_sys_ck" to
> fail. To fix this add new timer clock alias for using device-tree.
> 
> Please note that adding a 2nd set of clock aliases for the same clocks to only
> temporary until device-tree migration is complete. Then we can remove the legacy
> aliases. Hence, I have marked the legacy aliases with a "TODO" to remove them.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, queued for 3.7.

- Paul
