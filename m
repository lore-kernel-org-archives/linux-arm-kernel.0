From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Jun 2013 18:29:53 +0100
Subject: [PATCH] irqchip: gic: fix boot for chained gics
In-Reply-To: <1371227097-3326-1-git-send-email-mark.rutland@arm.com>
References: <1371227097-3326-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20130614172952.GU29271@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:24:57PM +0100, Mark Rutland wrote:
> As of c0114709ed: "irqchip: gic: Perform the gic_secondary_init() call
> via CPU notifier", booting on a platform with chained gics (e.g.
> Realview EB ARM11MPCore) will result in the gic_cpu_notifier being
> registered twice, corrupting the cpu notifier list and rendering the
> platform unbootable.
> 
> This patch ensures that we only register the notifier for the first gic,
> allowing platforms with chained gics to boot. At the same time we limit
> the pointlessly duplicated calls to set_smp_cross_call and
> set_handle_irq to the first gic registered.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
