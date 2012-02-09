From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 9 Feb 2012 17:03:45 -0600
Subject: [PATCH v2 4/4] ARM: remove empty disable_fiq and
 arch_ret_to_user macros
In-Reply-To: <1328751219-2552-5-git-send-email-robherring2@gmail.com>
References: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
 <1328751219-2552-5-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41F9DF63E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 08, 2012 6:34 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that most platforms don't need disable_fiq and arch_ret_to_user
> macros, we can remove the empty macros or empty entry-macro.S files.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Ryan Mallon <rmallon@gmail.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---

<...>

> arch/arm/mach-ep93xx/include/mach/entry-macro.S    |   17 ------------

<...>

delete mode 100644 arch/arm/mach-ep93xx/include/mach/entry-macro.S

<...>

> diff --git a/arch/arm/mach-ep93xx/include/mach/entry-macro.S b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
> deleted file mode 100644
> index 9be6edc..0000000
> --- a/arch/arm/mach-ep93xx/include/mach/entry-macro.S
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/*
> - * arch/arm/mach-ep93xx/include/mach/entry-macro.S
> - * IRQ demultiplexing for EP93xx
> - *
> - * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or (at
> - * your option) any later version.
> - */
> -
> -		.macro	disable_fiq
> -		.endm
> -
> -		.macro  arch_ret_to_user, tmp1, tmp2
> -		.endm

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
