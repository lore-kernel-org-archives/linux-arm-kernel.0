From: will.deacon@arm.com (Will Deacon)
Date: Sat, 10 Dec 2011 13:20:42 +0000
Subject: [PATCH 1/4] Add generic ARM instruction set condition code checks.
In-Reply-To: <20111209185422.19655.40836.stgit@localhost6.localdomain6>
References: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
 <20111209185422.19655.40836.stgit@localhost6.localdomain6>
Message-ID: <20111210132042.GB8292@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 06:54:29PM +0000, Leif Lindholm wrote:
> diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
> new file mode 100644
> index 0000000..aea97bf
> --- /dev/null
> +++ b/arch/arm/include/asm/opcodes.h
> @@ -0,0 +1,20 @@
> +/*
> + *  arch/arm/include/asm/opcodes.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARM_OPCODES_H
> +#define __ASM_ARM_OPCODES_H
> +
> +#ifndef __ASSEMBLY__
> +extern unsigned int arm_check_condition(unsigned int opcode, unsigned int psr);
> +#endif

You forgot to update the prototype arguments.

With that fixed,

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
