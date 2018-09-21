From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Sep 2018 09:18:22 -0700
Subject: [PATCH -next] pinctrl: sunxi: fix 'pctrl->functions' allocation
 in sunxi_pinctrl_build_state
In-Reply-To: <20180921015941.28468-1-yuehaibing@huawei.com>
References: <20180921015941.28468-1-yuehaibing@huawei.com>
Message-ID: <CACRpkdbHALf7m2uQ091dBmD9aTctzN2ym5=vZ1wFbE_ayJ-8Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 7:00 PM YueHaibing <yuehaibing@huawei.com> wrote:

> fixes following Smatch static check warning:
>
>  ./drivers/pinctrl/sunxi/pinctrl-sunxi.c:1112 sunxi_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
>
> As we will be calling krealloc() on pointer 'pctrl->functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
>
> Fixes: 0e37f88d9ad8 ("ARM: sunxi: Add pinctrl driver for Allwinner SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
