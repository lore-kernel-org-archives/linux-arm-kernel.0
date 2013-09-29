From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Sep 2013 01:12:10 +0200
Subject: [PATCH] ARM: ux500: cpuidle: fix section mismatch
In-Reply-To: <1380302195-18678-1-git-send-email-daniel.lezcano@linaro.org>
References: <1380302195-18678-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CACRpkdZN0ErvBSYuOK3XP5JgLZRqJ7Rvcc=sj=naT9c4tSSG5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 7:16 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> The dbx500_cpuidle_probe is tagged as an __init section but the variable
> dbx500_cpuidle_plat_driver is not.
>
> The dbx500_cpuidle_probe could not be declared as __init because of macro
> module_platform_driver builds the exit function, tags as __exit and this one
> refers to the dbx500_cpuidle_plat_driver which is an __initdata.
>
> That leads to a section mismatch.
>
> Fix it by removing the __init tag for the probe function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sorry if I caused this and thanks for fixing it up!

Yours,
Linus Walleij
