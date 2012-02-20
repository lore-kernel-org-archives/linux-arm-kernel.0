From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Feb 2012 13:31:54 +0000
Subject: [PATCH v7 2/8] ARM: davinci: create new common platform header
 for	davinci
In-Reply-To: <1324475021-32509-3-git-send-email-manjunath.hadli@ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
 <1324475021-32509-3-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317C78B6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Wed, Dec 21, 2011 at 19:13:35, Hadli, Manjunath wrote:
> remove individual platform header files for dm365, dm355, dm644x
> and dm646x and consolidate it into a single and common
> header file davinci.h placed in arch/arm/mach-davinci.
> 
> This reduces the pollution in the include/mach and is consistent
> with Russel's suggestions as part of his "pet peaves" mail.

While committing this patch, I fixed Russell's name and added
a link to his post.

> 
> The further patches in the series take  advantage of this consolidation
> for easy implementation of IO_ADDRESS elimination.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>

> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index 635bf77..123bea8 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -36,7 +36,6 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
> -#include <mach/dm646x.h>
>  #include <mach/common.h>
>  #include <mach/serial.h>
>  #include <mach/i2c.h>
> @@ -46,6 +45,7 @@
>  #include <mach/aemif.h>
>  
>  #include "clock.h"
> +#include "davinci.h"

In cases where multiple local include files are present,
I modified the patch to make davinci.h the first include
file. I did this to keep the new include order closer
to the original order.

> diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
> new file mode 100644
> index 0000000..238c282
> --- /dev/null
> +++ b/arch/arm/mach-davinci/davinci.h
> @@ -0,0 +1,85 @@
> +/*
> + * This file contains the processor specific definitions
> + * of the TI DM644x, DM355, DM365, and DM646x.
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated

Deep Root Systems had a copyright on one of the files
this code is derived from. I restored the copyright of
Deep Root Systems in the file.

[...]

> +/* DM355 function declarations */
> +struct spi_board_info;

I saw no reason to maintain a forward declaration like this.
I included linux/spi/spi.h in this file instead.

I am making these changes myself since I was delayed in getting
back to you and also since you have already spun 7 versions of
this. I figured you must be getting tired already ;-)

I will push the code to a branch on my tree, please give it a
good test.

Thanks,
Sekhar
