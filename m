From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jun 2016 10:33:25 +0200
Subject: [PATCH] pinctrl: stm32: Modify error handling for pinctrl_register
In-Reply-To: <20160627142310.GA26798@amitoj-Inspiron-3542>
References: <20160627142310.GA26798@amitoj-Inspiron-3542>
Message-ID: <CACRpkdZURfExVneWCWT6xW4xgdVrFAoDYBfn=t2RKsohLzTb4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 4:23 PM, Amitoj Kaur Chawla
<amitoj1606@gmail.com> wrote:

> pinctrl_register returns an ERR_PTR on error.
>
> The Coccinelle semantic patch used to make this change is as follows:
>
> @@
> expression e,e1,e2;
> @@
>
> e = pinctrl_register(...)
> ... when != e = e1
> if (
> -   e == NULL
> +   IS_ERR(e)
>    ) {
>      ...
>      return
> -      e2
> +      PTR_ERR(e)
>      ;
>      }
>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

I already have a patch like this in my tree it seems.

But very nice that cocinelle is now finding this!

Yours,
Linus Walleij
