From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Aug 2013 22:37:32 +0200
Subject: [PATCH 4/5] pinctrl: imx: do not fail when parsing a function
 fails
In-Reply-To: <1376050854-3303-5-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CACRpkdaFNNtEbCx2AKXuFW0MPFtkwkY9WOxUkmxJaAx0aDP11w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 9, 2013 at 2:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> When parsing a function fails this is no reason to make the whole
> driver fail. Just continue with the next function.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
(...)
> -       for_each_child_of_node(np, child) {
> -               ret = imx_pinctrl_parse_functions(child, info, i++);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "failed to parse function\n");
> -                       return ret;
> -               }
> -       }
> +       for_each_child_of_node(np, child)
> +               imx_pinctrl_parse_functions(child, info, i++);

But is there a reason to stop printing an error message
about it?

Yours,
Linus Walleij
