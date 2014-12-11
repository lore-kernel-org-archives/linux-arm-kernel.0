From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Dec 2014 14:32:05 +0000
Subject: [PATCH 4/4] ARM: add 32bit support to GICv3
In-Reply-To: <1418307788-17977-5-git-send-email-jean-philippe.brucker@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
 <1418307788-17977-5-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <20141211143205.GP11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 02:23:08PM +0000, Jean-Philippe Brucker wrote:
> +#ifndef __ASM_ARCH_GICV3_H
> +#define __ASM_ARCH_GICV3_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/io.h>

This should be linux/io.h

> +/* Low-level accessors */
> +
> +static inline void __maybe_unused gic_write_eoir(u32 irq)

No need for __maybe_unused with static inline.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
