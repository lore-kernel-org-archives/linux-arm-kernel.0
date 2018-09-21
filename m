From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Sep 2018 09:11:38 -0700
Subject: [PATCH 1/4] pinctrl: mediatek: fix static checker warning caused
 by EINT_NA
In-Reply-To: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdavhUsJkd262rgjk=2RdHVrdmAi+8JHGBMHEDv_w=gnVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 9:07 PM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> EINT_NA is an u16 number, so it should be U16_MAX instead of -1
> to fix up drivers/pinctrl/mediatek/pinctrl-paris.c:732 mtk_gpio_to_irq()
> warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> Also happens in
> drivers/pinctrl/mediatek/pinctrl-paris.c:749 mtk_gpio_set_config()
> warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> drivers/pinctrl/mediatek/pinctrl-moore.c:479 mtk_gpio_to_irq()
> warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> drivers/pinctrl/mediatek/pinctrl-moore.c:496 mtk_gpio_set_config()
> warn: impossible condition '(desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> Fixes: 6561859b067f ("pinctrl: mediatek: add eint support to MT8183 pinctrl driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
