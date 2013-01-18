From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Jan 2013 20:26:23 +0100
Subject: [PATCH 3/7] ARM: pinctrl: sunxi: Add the pinctrl pin set for sun5i
In-Reply-To: <1357681398-23956-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1357681398-23956-1-git-send-email-maxime.ripard@free-electrons.com>
 <1357681398-23956-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZAXeMU=HXf36C6+737+8+fYkfcxSZqYc=Wp095aboOUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 10:43 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Since the Allwinner SoCs variants don't have the same set of pins to
> handle, we need to declare the pin ranges available.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
(...)
>  static struct of_device_id sunxi_pinctrl_match[] __devinitconst = {

I think __devinitconst is also deprecated.

> +       { .compatible = "allwinner,sun5i-a13-pinctrl", .data = (void *)&sun5i_a13_pinctrl_data },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_pinctrl_match);

Aha so the match table is in the subdrivers, hm.... OK.

Yours,
Linus Walleij
