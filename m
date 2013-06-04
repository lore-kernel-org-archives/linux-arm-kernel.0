From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Jun 2013 07:52:52 -0700
Subject: [PATCH RFC 1/3] clk: omap: introduce clock driver
In-Reply-To: <1370327958-19776-2-git-send-email-mturquette@linaro.org>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370327958-19776-2-git-send-email-mturquette@linaro.org>
Message-ID: <20130604145252.GJ3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [130603 23:45]:
> Parses OMAP clock data from DT and registers those clocks with the clock
> framework.  dt_omap_clk_init must be called early during boot for timer
> initialization so it is exported and called from the existing clock code
> instead of probing like a real driver.

Thanks for doing this, makes sense to me. I have queued up patches to
make omap4 DT only, so this is the way to go.

> --- /dev/null
> +++ b/include/linux/clk/omap.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2010 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __LINUX_CLK_OMAP_H_
> +#define __LINUX_CLK_OMAP_H_
> +
> +int __init dt_omap_clk_init(void);
> +
> +#endif

Maybe leave out the Broadcom copyright from this header? :)

Regards,

Tony
