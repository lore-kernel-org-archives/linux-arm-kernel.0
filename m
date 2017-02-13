From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Feb 2017 15:49:15 +0100
Subject: [PATCH -next v2] pinctrl: samsung: Fix return value check in
 samsung_pinctrl_get_soc_data()
In-Reply-To: <20170205155849.4362-1-weiyj.lk@gmail.com>
References: <20170125140321.23911-1-weiyj.lk@gmail.com>
 <20170205155849.4362-1-weiyj.lk@gmail.com>
Message-ID: <CACRpkda0BYLNpPFwpNaEMdeyx61KDUQz_6Y=FQj340pViFjVVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 5, 2017 at 4:58 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). Fix by using devm_ioremap_resource instead of devm_ioremap.
>
> Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple
> IORESOURCE_MEM for one pin-bank")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: use devm_ioremap_resource instead of devm_ioremap

Patch applied with Krzysztof's ACK.

Yours,
Linus Walleij
