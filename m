From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Feb 2016 23:01:44 +0100
Subject: linux-4.5-rc3/arch/arm/mach-ux500/cpu-db8500.c:89: statement
 after return ?
In-Reply-To: <DUB128-W6810AD43780578EF2A48789CD50@phx.gbl>
References: <DUB128-W6810AD43780578EF2A48789CD50@phx.gbl>
Message-ID: <CACRpkdbTB9VROfKyiyY4gzWQD-UHio1UnoYu-GuHkzgL5ZgoRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2016 at 4:50 PM, David Binderman <dcb314@hotmail.com> wrote:

> Hello there,
>
> [linux-4.5-rc3/arch/arm/mach-ux500/cpu-db8500.c:89]: (style) Statements following return, break, continue, goto or throw will never be executed.
>
> Source code is
>
>     return kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
>              readl((u32 *)uid+0),
>              readl((u32 *)uid+1), readl((u32 *)uid+2),
>              readl((u32 *)uid+3), readl((u32 *)uid+4));
>     iounmap(uid);
> }
>
> This looks like a cut-n-paste error to me. Suggest rework.

I sent a patch for this, nice catch.

Yours,
Linus Walleij
