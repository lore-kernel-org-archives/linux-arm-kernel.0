From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 17 May 2011 19:30:29 +0530
Subject: [PATCH] ARM: smp_twd: Reconfigure clockevents after cpufreq change
In-Reply-To: <1305588114-23728-1-git-send-email-ccross@android.com>
References: <1305588114-23728-1-git-send-email-ccross@android.com>
Message-ID: <4DD27F7D.2070305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

On 5/17/2011 4:51 AM, Colin Cross wrote:
> The localtimer's clock changes with the cpu clock.  After a
> cpufreq transition, update the clockevent's frequency and
> reprogram the next clock event.
>
> Adds a clock called "smp_twd" that is used to determine the
> twd frequency, which can also be used at init time to
> avoid calibrating the twd frequency.
>
> Signed-off-by: Colin Cross<ccross@android.com>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Russell King<linux@arm.linux.org.uk>
> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Rob Herring<robherring2@gmail.com>
> ---
>   arch/arm/kernel/smp_twd.c |   69 +++++++++++++++++++++++++++++++++++++++++++--
>   1 files changed, 66 insertions(+), 3 deletions(-)
>
> This patch depends on Thomas Gleixner's patch to add clockevents_reconfigure
> See: https://lkml.org/lkml/2011/5/13/122
>
> This patch adds a clock that can be used to skip calibration as well
> as update the frequency.  A later patch (or a later version of this patch)
> will drop twd_calibrate_rate once all platforms provide the necessary
> smp_twd clock.
>

Since the "smp_twd" clock node will not have a clk_set_rate()
associated with it, will the clk_get_rate() gives you real
rate. May be we can associate this node as a child of
CPU clock node and use the fixed divider based on peripheral
ratio. Is that the idea here to realize it ?

Regards,
Santosh
