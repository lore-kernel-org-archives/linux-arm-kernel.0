From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 May 2014 21:19:55 +0100
Subject: [PATCH v8 5/8] arm64: Add ftrace support
In-Reply-To: <1398851676-16389-6-git-send-email-takahiro.akashi@linaro.org>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-6-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140528201955.GJ5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 06:54:33PM +0900, AKASHI Takahiro wrote:

> +/*
> + * arch/arm64/kernel/entry-ftrace.S
> + *
> + * Copyright (C) 2013 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/ftrace.h>
> +#include <asm/insn.h>

asm/insn.h contains a bunch of C stuff which won't build without
__ASSEMBLY__ guards unless I'm missing something (I'm working with a
non-mainline tree so I might be).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/d1863090/attachment.sig>
