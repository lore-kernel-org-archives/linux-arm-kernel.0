From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Jul 2013 00:06:12 +0200
Subject: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
In-Reply-To: <20130607205044.16513.27675.stgit@localhost>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205044.16513.27675.stgit@localhost>
Message-ID: <CACRpkdathAjMtTGXz9U7EhsNEqdRCtxFuwQ2SFb=k8HEUewpAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 10:50 PM, Tony Lindgren <tony@atomide.com> wrote:

> For wake-up events from deeper idle modes we need to check the
> configured padconf registers for the wake-up bit and then call
> the related interrupt handler.
>
> Done in collaboration with Roger Quadros <rogerq@ti.com>.
>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
(...)
> +                       pcsoi->gpio = r->gpio;

This "gpio" member appear to be used nowhere, which is probably
related to what I was saying about custom GPIO interfaces doing
pinconf, but I could be wrong...

> +/*
> + * Note that omap2430 has 8-bit padconf registers and uses
> + * the plain pinctrl-single binding.
> + */
> +static const struct of_device_id pcs_omap_of_match[] = {
> +       { .compatible = "ti,omap3-padconf", },
> +       { .compatible = "ti,omap4-padconf", },
> +       { .compatible = "ti,omap5-padconf", },
> +       {}
> +};

Goes into some binding document?

Yours,
Linus Walleij
