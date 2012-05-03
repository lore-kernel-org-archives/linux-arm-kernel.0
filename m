From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 03 May 2012 16:47:44 +0530
Subject: [PATCH 0/8] gpio/omap: remaining cleanups and fix
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <4FA26958.4010304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun,

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> Here are the remaining cleanup patches. There are broadly
> two categories of cleanups.
> 
> Cat-1: Those missed while introducing new feature like SPARSE_IRQ
>        handling and DT support; use edge/level handlers from
>        generic IRQ framework.
> 
> Cat-2: Removal of redundant fields from struct gpio_bank{} as a
>        result of they being already covered by members within
>        context field of struct gpio_bank{}.
> 
> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Commit: 66f75a5d028beaf67c931435fdc3e7823125730c (Linux 3.4-rc4)
> 
> Series is available for reference here:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev.git for_3.5/gpio_more_cleanup_fixes
> 
> Test info:
> OMAP2+ platforms: OMAP2430SDP, OMAP3430SDP, OMAP4430SDP
> OMAP1: Bootup test on OMAP1710SDP.
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Tarun Kanti DebBarma (8):
>   gpio/omap: remove virtual_irq_start variable
>   gpio/omap: remove saved_fallingdetect, saved_risingdetect
>   gpio/omap: remove suspend_wakeup field from struct gpio_bank
>   gpio/omap: remove saved_wakeup field from struct gpio_bank
>   gpio/omap: remove retrigger variable in gpio_irq_handler
>   gpio/omap: remove suspend/resume callbacks
>   gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()
>   gpio/omap: fix missing check in *_runtime_suspend()
> 
I have reviewed the remaining 3 patches from this series.
Thanks.

Regards
santosh
