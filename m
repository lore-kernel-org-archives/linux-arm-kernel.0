From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jun 2014 09:51:24 +0100
Subject: [PATCH 09/24] ARM64:ILP32: Use the same syscall names as LP64.
In-Reply-To: <1400914939-9708-10-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <1400914939-9708-10-git-send-email-apinski@cavium.com>
Message-ID: <20140618085124.GA11977@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 12:02:04AM -0700, Andrew Pinski wrote:
> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
> index 1caadc2..067eab0 100644
> --- a/arch/arm64/include/uapi/asm/unistd.h
> +++ b/arch/arm64/include/uapi/asm/unistd.h
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2014 Cavium Inc.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -13,4 +14,10 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> +
> +/* For ILP32 AARCH64, we want to use the non compat names. */
> +#if defined(__aarch64__) && defined(__ILP32__)

Another inconsistency for !__LP64__ vs __ILP32__. BTW, do we still need
__aarch64__ check? Do we expect these headers to be used with AArch32?

> +#define __SYSCALL_NONCOMPAT

As I mentioned in a previous patch, I prefer something like
__ARCH_WANT...

-- 
Catalin
