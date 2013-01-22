From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 22 Jan 2013 04:25:58 +0100
Subject: [PATCH] ARM: ux500: de-globalize <mach/id.h>
In-Reply-To: <1357546827-10154-1-git-send-email-linus.walleij@stericsson.com>
References: <1357546827-10154-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130122032558.GJ7409@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Jan 07, 2013 at 09:20:27AM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This removes the file <mach/id.h> from the global kernel include
> scope, making it a pure mach-ux500 detail. All ASIC specifics
> needed by drivers shall henceforth be passed from either platform
> data or the device tree.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm sending this as a preview, collecting ACKs for the next
> merge window.
> 
> Sam, Rafael, could you ACK this?
> 
> Linus Walleij
> ---
>  arch/arm/mach-ux500/board-mop500-uib.c      |   1 +
>  arch/arm/mach-ux500/cache-l2x0.c            |   3 +-
>  arch/arm/mach-ux500/cpu-db8500.c            |   2 +
>  arch/arm/mach-ux500/cpu.c                   |   1 +
>  arch/arm/mach-ux500/id.c                    |   2 +
>  arch/arm/mach-ux500/id.h                    | 144 ++++++++++++++++++++++++++++
>  arch/arm/mach-ux500/include/mach/hardware.h |   1 -
>  arch/arm/mach-ux500/include/mach/id.h       | 144 ----------------------------
>  arch/arm/mach-ux500/platsmp.c               |   3 +
>  arch/arm/mach-ux500/timer.c                 |   2 +
>  drivers/cpufreq/db8500-cpufreq.c            |   3 -
>  drivers/mfd/db8500-prcmu.c                  |  17 ++--
>  include/linux/mfd/dbx500-prcmu.h            |   2 -
For the MFD bits:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
