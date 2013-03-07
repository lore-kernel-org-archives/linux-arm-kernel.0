From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 08:48:12 +0100
Subject: [PATCH] pinctrl: single: avoid to set read only object
In-Reply-To: <1362322904-19570-1-git-send-email-haojian.zhuang@linaro.org>
References: <1362322904-19570-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdb-PP+BPhYZhLPnuuww5Lg2YevgvviZP4mS4XpGHAi8og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 3, 2013 at 4:01 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> drivers/pinctrl/pinctrl-single.c:1441:3: error: assignment of member
> ?is_generic? in read-only object
> make[2]: *** [drivers/pinctrl/pinctrl-single.o] Error 1
>
> Since pcs_pinconf_ops is changed to read only structure, probe()
> function can't set is_generic variable any more. So append new
> pcs_pinconf_generic_ops.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Isn't this fixed by Axel's much simpler patch?

Yours,
Linus Walleij
