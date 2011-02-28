From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Feb 2011 11:20:55 +0000
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <42efee69-aca1-446b-a997-f0063e113877@VA3EHSMHS009.ehs.local>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-2-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-3-git-send-email-john.linn@xilinx.com>
	<42efee69-aca1-446b-a997-f0063e113877@VA3EHSMHS009.ehs.local>
Message-ID: <20110228112055.GC29843@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 11:14:40AM -0700, John Linn wrote:
> diff --git a/arch/arm/mach-xilinx/include/mach/uncompress.h b/arch/arm/mach-xilinx/include/mach/uncompress.h
> new file mode 100644
> index 0000000..ff3754c
> --- /dev/null
> +++ b/arch/arm/mach-xilinx/include/mach/uncompress.h
> @@ -0,0 +1,61 @@
> +/* arch/arm/mach-xilinx/include/mach/uncompress.h
> + *
> + *  Copyright (C) 2011 Xilinx
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __MACH_UNCOMPRESS_H__
> +#define __MACH_UNCOMPRESS_H__
> +
> +#include <mach/xilinx_soc.h>
> +#include <mach/uart.h>
> +#include <asm/processor.h>
> +#include <asm/io.h>
> +#include <mach/io.h>

You don't need mach/io.h here - it's already included by asm/io.h.
It's probably also worth trying linux/io.h instead of asm/io.h too.
