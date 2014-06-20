From: geoff@infradead.org (Geoff Levand)
Date: Fri, 20 Jun 2014 10:03:30 -0700
Subject: [PATCHv3 3/4] arm64: Update the Image header
In-Reply-To: <1403174963-10730-4-git-send-email-mark.rutland@arm.com>
References: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
 <1403174963-10730-4-git-send-email-mark.rutland@arm.com>
Message-ID: <1403283810.17030.68.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, 2014-06-19 at 11:49 +0100, Mark Rutland wrote: 
> diff --git a/arch/arm64/include/asm/image.h b/arch/arm64/include/asm/image.h
> new file mode 100644
> index 0000000..8fae075
> --- /dev/null
> +++ b/arch/arm64/include/asm/image.h
> @@ -0,0 +1,62 @@
> +/*
> + * Linker script macros to generate Image header fields.

...

> + */
> +#ifndef __ASM_IMAGE_H
> +#define __ASM_IMAGE_H
> +
> +#ifndef LINKER_SCRIPT
> +#error This file should only be included in vmlinux.lds.S
> +#endif

Since this is just used by the linker script, shouldn't it go in
arch/arm64/kernel/image.h?

-Geoff
