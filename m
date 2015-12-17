From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Dec 2015 11:38:01 +0000
Subject: [PATCH v6 07/20] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
In-Reply-To: <1450215766-14765-8-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-8-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151217113801.GC25232@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:33AM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
> new file mode 100644
> index 0000000..476db90
> --- /dev/null
> +++ b/arch/arm64/include/asm/is_compat.h
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright (C) 2015 Cavium Inc.

Moving code around and changing function names doesn't exactly mean a
change in copyright (though it's not that much code).

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ASM_IS_COMPAT_H
> +#define __ASM_IS_COMPAT_H
> +#ifdef __KERNEL__

Nitpick: I thought we no longer need __KERNEL__ for non-uapi header files.

-- 
Catalin
