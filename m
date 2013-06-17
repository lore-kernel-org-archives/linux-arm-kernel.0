From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:29:40 +0200
Subject: [RFC PATCH 02/11] dma: amba-pl08x: Refactor pl08x_getbytes_chan()
 to lower indentation
In-Reply-To: <1371416058-22047-3-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdaE_pFefFgMyEgGe_rRb61gOVxmihx6VNYA0Wo2w4-hmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Further patch will introduce support for PL080S, which requires some
> things to be done conditionally, thus increasing indentation level of
> some functions even more.
>
> This patch reduces indentation level of pl08x_getbytes_chan() function
> by inverting several conditions and returning from function wherever
> possible.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Nice refactoring and a patch that should be applied immediately
no matter what happens with the rest.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

PS:

> +       if (!ch || !txd)
> +               return bytes;

Just return 0; is even clearer in this case but who cares.

Yours,
Linus Walleij
