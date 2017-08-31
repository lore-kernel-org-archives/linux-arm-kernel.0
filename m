From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 15:41:49 +0200
Subject: [PATCH v3] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <1503418601-9728-1-git-send-email-yamada.masahiro@socionext.com>
References: <1503418601-9728-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYG3BFhhpouwAkQN+x0YpC5EhsVhTkqyuNdRd26Ne-r9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 6:16 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This GPIO controller device is used on UniPhier SoCs.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v3:
>   - Add .irq_set_affinity() hook
>   - Use irq_domain_create_hierarchy() instead of legacy
>     irq_domain_add_hierarchy().

This is getting better and better.

> +static const u32 uniphier_gpio_irq_parent_hwirqs[] = {
> +       48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
> +       154, 155, 156, 157, 158, 217, 218, 219,
> +};

This array which is used when allocating the hierarchical domain
looks like configuration data. Why is it not in the device tree?

Yours,
Linus Walleij
