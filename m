From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Nov 2012 12:36:01 +0000
Subject: [PATCH 1/1] ARM: ux500: Fix u9540 booting issues
In-Reply-To: <1354008890-10476-1-git-send-email-lee.jones@linaro.org>
References: <1354008890-10476-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201211271236.01493.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 November 2012, Lee Jones wrote:

> The u9540 stopped booting after the v3.7 merge window due to
> a lack of common clk support and early PRCMU initialisation.
> In this patch we rectify these issues, placing the u9540
> development board back into a successfully booting state.

> -       if (cpu_is_u8500_family())
> +       if (cpu_is_u8500_family() || cpu_is_u9540())
>                 u8500_clk_init();
> -       else if (cpu_is_u9540())
> -               u9540_clk_init();
>         else if (cpu_is_u8540())
>                 u8540_clk_init();

It certainly doesn't /look/ right, even if it works.  Can you explain why
u8540_clk_init works and u9540_clk_init doesn't?

	Arnd
