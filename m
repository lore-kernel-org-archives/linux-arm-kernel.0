From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Mar 2017 15:54:41 +0200
Subject: [PATCH] mtd: physmap_of: really fix the physmap add-ons
In-Reply-To: <20170326122725.5594-1-linus.walleij@linaro.org>
References: <20170326122725.5594-1-linus.walleij@linaro.org>
Message-ID: <CACRpkdaLR2v9hX60BDANd8QJGRp2t4aFN-+yWyJrFXBaoXEgjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 2:27 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

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
> The previous attempts to bake a single module from several *optional*
> pieces doesn't play well with tristate, and if there is a way to
> achieve that except making everything an #ifdef in the same file,
> I sure haven't figured it out. I guess #include "physmap_addon.c"
> directly into the C file would work but ugh that is ugly.

Bah, the build servers claim this doesn't work either.

OK investigating again, sigh. Kbuild always bites my ass.

Yours,
Linus Walleij
