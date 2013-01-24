From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Jan 2013 11:03:14 +0530
Subject: [PATCH 4/4] irqchip: gic: Perform the gic_secondary_init() call
 via CPU notifier
In-Reply-To: <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <5100C79A.1080305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 January 2013 11:29 PM, Catalin Marinas wrote:
> All the calls to gic_secondary_init() pass 0 as the first argument.
> Since this function is called on each CPU when starting, it can be done
> in a platform-independent way via a CPU notifier registered by the GIC
> code.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

[..]

> ---
>
Nice to see GIC is converted as well like timers. The trick
as you mentioned about higher priority of GIC than timer
is key for correct initialization of secondary CPUs.

For OMAP changes and the series,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
