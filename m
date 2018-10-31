From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Oct 2018 14:35:43 +0100
Subject: [PATCH 2/2 v2] mfd: ab8500-core: Return zero in
 get_register_interruptible()
In-Reply-To: <20181025124344.xw3phqnvrwq2nj7g@kili.mountain>
References: <20181025101037.GR4939@dell>
 <20181025124344.xw3phqnvrwq2nj7g@kili.mountain>
Message-ID: <CACRpkdYcmse-dRkDW-6Fvx9ojwj3XXWBWdOM-FXyWYyP11cj9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 2:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This function is supposed to return zero on success or negative error
> codes on error.  Unfortunately, there is a bug so it sometimes returns
> non-zero, positive numbers on success.
>
> I noticed this bug during review and I can't test it.  It does appear
> that the return is sometimes propogated back to _regmap_read() where all
> non-zero returns are treated as failure so this may affect run time.
>
> Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: In v1, I introduced an new error path and forgot to drop the lock.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I've got some cleanup work to do with this driver.
Getting to it.

Yours,
Linus Walleij
