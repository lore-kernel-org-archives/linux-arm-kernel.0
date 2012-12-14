From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Dec 2012 16:46:02 +0100
Subject: [PATCH] drivers/pinctrl/pinctrl-at91.c: convert kfree to
 devm_kfree
In-Reply-To: <alpine.DEB.2.02.1212121521590.1995@hadrien>
References: <1355223525-19165-1-git-send-email-Julia.Lawall@lip6.fr>
 <20121212115624.GI4398@game.jcrosoft.org>
 <alpine.DEB.2.02.1212121521590.1995@hadrien>
Message-ID: <CACRpkdbTKB+evcoqp02GBAnWOZ-06pEB_u=ssXQFdi5ZvV_8FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 3:22 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> The function at91_dt_node_to_map is ultimately called by the function
> pinctrl_get, which is an exported function.  Since it is possible that this
> function is not called from within a probe function, for safety, the kfree
> is converted to a devm_kfree, to both free the data and remove it from the
> device in a failure situation.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
> v2: Drop cleanup of the call to devm_kzalloc at the same time.

Thanks, applied with Jean-Christophe's ACK.

Yours,
Linus Walleij
