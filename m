From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 12:08:50 +0100
Subject: [PATCH 09/24] msm: MSM8X60 RUMI3 board support
In-Reply-To: <1282712273-344-10-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-10-git-send-email-johlstei@codeaurora.org>
Message-ID: <20100902110850.GV26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 24, 2010 at 09:57:38PM -0700, Jeff Ohlstein wrote:
> diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
> new file mode 100644
> index 0000000..3ab4bd9
> --- /dev/null
> +++ b/arch/arm/mach-msm/board-msm8x60.c
> @@ -0,0 +1,59 @@
> +/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/hardware/gic.h>
> +
> +#include <mach/board.h>
> +#include <mach/msm_iomap.h>
> +#include <mach/io.h>

linux/io.h

> +
> +extern struct sys_timer msm_timer;
> +void __iomem *gic_cpu_base_addr;

Please move to a header file.
