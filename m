From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 29 Mar 2017 16:51:37 +0200
Subject: [PATCH v2] mtd: physmap_of: really fix the physmap add-ons
In-Reply-To: <20170327151658.6175-1-linus.walleij@linaro.org>
References: <20170327151658.6175-1-linus.walleij@linaro.org>
Message-ID: <20170329165137.05336eaf@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, 27 Mar 2017 17:16:58 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> The current way of building the of_physmap add-ons result in just
> the add-on being in the object code, and not the actual core
> implementation and regress the Gemini and Versatile.
> 
> There is no way around exporting these functions. If they are
> built as modules, they will become modules with exported functions,
> if they are builtins they will become builtins.
> 
> Fixes: 4f04f68e1598 ("mtd: physmap_of: fixup gemini/versatile dependencies")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Make the Kconfig entries tristate so they can follow the config
>   of the main code portions.
> - Use the IS_ENABLED() macro from <linux/kconfig.h> to determine
>   whether a certain function is available for builtin OR module.
>   This is finally the silver bullet: allyes and allmod builds
>   fine on x86_64.

Did you try something like that [1]? This way you wouldn't have to
export the gemini and versatile symbols and the core code would still
be embedded in the object file.

Regards,

Boris

[1]http://code.bulix.org/i810qd-124738
