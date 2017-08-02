From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 10:31:59 +0200
Subject: [PATCH] pinctrl: zte: fix 'functions' allocation in
 zx_pinctrl_build_state()
In-Reply-To: <1500212008-29321-1-git-send-email-shawnguo@kernel.org>
References: <1500212008-29321-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CACRpkdbXYOv8FdbWoiwL-4mhBN5JSP3D8iMMjFM1H2u-vgUC-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 16, 2017 at 3:33 PM, Shawn Guo <shawnguo@kernel.org> wrote:

> From: Shawn Guo <shawn.guo@linaro.org>
>
> It fixes the following Smatch static check warning:
>
>  drivers/pinctrl/zte/pinctrl-zx.c:338 zx_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree.
>
> As we will be calling krealloc() on pointer 'functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: cbff0c4d27f4 ("pinctrl: add ZTE ZX pinctrl driver support")
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Patch applied.

Yours,
Linus Walleij
