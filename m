From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Sep 2013 10:21:16 +0200
Subject: [PATCH v3 1/7] pinctrl: imx1 core driver
In-Reply-To: <1378020488-21129-2-git-send-email-mpa@pengutronix.de>
References: <1378020488-21129-1-git-send-email-mpa@pengutronix.de>
 <1378020488-21129-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdYH6LwmU0jHBVekrvQMKsz4YOeEWeFa-uFqZ=MjGLFZkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 1, 2013 at 9:28 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> Core driver for register formats of imx1/imx21/imx27 processors.
>
> The pins of those processors are grouped into ports. Each port has 32
> pins. The pins mux configuration is controlled by registers with 1 or 2
> bit per pin, depending on the specific control register.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

This patch set needs to be rebased and tested on top of v3.12-rc1.
Or preferably even my "devel" branch in the pinctrl tree.

For example:

> +static int imx1_pinconf_set(struct pinctrl_dev *pctldev,
> +                            unsigned pin_id, unsigned long config)
> +{
> +       struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct imx1_pinctrl_soc_info *info = ipctl->info;
> +
> +       imx1_write_bit(ipctl, pin_id, config & 0x01, MX1_PUEN);
> +
> +       dev_dbg(ipctl->dev, "pinconf set pullup pin %s\n",
> +               info->pins[pin_id].name);
> +
> +       return 0;
> +}

This function need to change signature.

Check commit 03b054e9696c3cbd3d5905ec96da15acd0a2fe8d

Please resend all 7 patches and add Shawns+Saschas ACKs
when you have rebased and tested the result.

Thanks!
Linus Walleij
