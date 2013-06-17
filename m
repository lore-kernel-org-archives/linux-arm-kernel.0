From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:39:34 +0200
Subject: [RFC PATCH 04/11] dma: amba-pl08x: Add support for PL080S variant
In-Reply-To: <1371416058-22047-5-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-5-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZ+g-_AC=2WBs3nruyTMX16Ona99g_wcS=PqOuZ6xVpog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> PL080S is a modified version of PL080 that can be found on Samsung SoCs,
> such as S3C6400 and S3C6410.
>
> It has different offset of CONFIG register, separate CONTROL1 register
> that holds transfer size and larger maximum transfer size.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

(I would have done some smallish things differently but it
is only a matter of taste.)

>  static struct amba_id pl08x_ids[] = {
> +       /* Samsung PL080S variant */
> +       {
> +               .id     = 0x0a141080,
> +               .mask   = 0xffffffff,
> +               .data   = &vendor_pl080s,
> +       },

Interesting that Samsung claim to be vendor 0x41
(ARM). Well ARM never made revision no 0x0a so
this works.

Yours,
Linus Walleij
