From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Sep 2015 10:56:41 +0200
Subject: [PATCH 2/2] pinctrl: digicolor: convert null test to IS_ERR test
In-Reply-To: <1440450747-10080-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1440450747-10080-1-git-send-email-Julia.Lawall@lip6.fr>
 <1440450747-10080-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdb4-iq7GYYjxub7dtyjRNWipJNx0NULPo8VywTKKPE5YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:12 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Since commit 323de9efdf3e ("pinctrl: make pinctrl_register() return proper
> error code"), pinctrl_register returns an error code rather than NULL on
> failure.  Update a driver that was introduced more recently.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
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
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch applied for fixes.

Yours,
Linus Walleij
