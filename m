From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 09:52:19 +0100
Subject: [PATCH 1/6] arm: sa1100: h3100: refactor LCD GPIO handling
In-Reply-To: <1385048414-9812-2-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
 <1385048414-9812-2-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdbmcCNCg-4A1bRTszwE3yQf7BPcFxKE3LiH8eJpJBMezA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> +static bool h3100_lcd_request(void)
> +{
> +       static bool h3100_lcd_ok;
> +       int rc;
> +
> +       if (h3100_lcd_ok)
> +               return true;
> +
> +       rc = gpio_request_array(h3100_lcd_gpio, ARRAY_SIZE(h3100_lcd_gpio));
> +       if (rc)
> +               pr_err("%s: can't request GPIOs\n", __func__);
> +       else
> +               h3100_lcd_ok = true;
> +
> +       return h3100_lcd_ok;
> +}

Hm hm this design pattern is somewhat strange, a run-once
construct, but OK then.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
