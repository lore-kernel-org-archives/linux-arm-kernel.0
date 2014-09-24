From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Sep 2014 13:23:09 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
Message-ID: <CACRpkda-K7w-bY0uSdnZvzEKEeQg38oExoHPSW61kEv9Wv20mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 5:39 AM, Hongzhou.Yang
<srv_hongzhou.yang@mediatek.com> wrote:

> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
>
> Add pinctrl node to mt8135.dtsi.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
(...)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_GPIO0 (MT_PIN_NO(0) | 0)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7 (MT_PIN_NO(0) | 1)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_EINT49 (MT_PIN_NO(0) | 2)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_I2SOUT_DAT (MT_PIN_NO(0) | 3)

I haven't got to reviewing the driver, but this looks just wrong.

Have the magic numbers in the driver.

Use strings to describe functions, not integers.

We need to move toward standardized device tree bindings
for this stuff, and that means using strings, not magic
numbers.

Yours,
Linus Walleij
