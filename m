From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Jan 2013 09:34:49 -0700
Subject: [PATCH] timer: vt8500: Move timer code to drivers/clocksource
In-Reply-To: <1358140171-25390-2-git-send-email-linux@prisktech.co.nz>
References: <1358140171-25390-1-git-send-email-linux@prisktech.co.nz>
 <1358140171-25390-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <50F433A9.8020105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2013 10:09 PM, Tony Prisk wrote:
> This patch moves arch-vt8500/timer.c into drivers/clocksource and
> updates the necessary Kconfig/Makefile options.

> diff --git a/include/linux/vt8500_timer.h b/include/linux/vt8500_timer.h

> +#ifndef __VT8500_TIMER_H
> +#define __VT8500_TIMER_H
> +
> +#include <asm/mach/time.h>
> +
> +void vt8500_timer_init(void);
> +
> +#endif

Is VT8500 DT-only? If so, it'd be nice not to add this header, but
instead use CLOCKSOURCE_OF_DECLARE() inside the driver C file.
