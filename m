From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Oct 2013 11:03:50 +0100
Subject: [PATCH v3 3/3] ARM: add support for bit sliced AES using NEON
 instructions
In-Reply-To: <1380913419-13296-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1380913419-13296-1-git-send-email-ard.biesheuvel@linaro.org>
 <1380913419-13296-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131013100350.GZ25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 09:03:39PM +0200, Ard Biesheuvel wrote:
> diff --git a/arch/arm/crypto/aesbs-glue.c b/arch/arm/crypto/aesbs-glue.c
> new file mode 100644
> index 0000000..4522366
> --- /dev/null
> +++ b/arch/arm/crypto/aesbs-glue.c
> @@ -0,0 +1,434 @@
> +/*
> + * linux/arch/arm/crypto/aesbs-glue.c - glue code for NEON bit sliced AES
> + *
> + * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/neon.h>
> +#include <crypto/aes.h>
> +#include <crypto/ablk_helper.h>

This header file doesn't appear to exist, and so causes this build error:

  CC      arch/arm/crypto/aesbs-glue.o
arch/arm/crypto/aesbs-glue.c:13:32: fatal error: crypto/ablk_helper.h: No such fcompilation terminated.
make[2]: *** [arch/arm/crypto/aesbs-glue.o] Error 1
make[2]: Target `__build' not remade because of errors.
make[1]: *** [arch/arm/crypto] Error 2
