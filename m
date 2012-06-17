From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 17 Jun 2012 11:13:28 -0300
Subject: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
In-Reply-To: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 10:44 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> ? ? ? ?uap->pinctrl = devm_pinctrl_get(&dev->dev);
> ? ? ? ?if (IS_ERR(uap->pinctrl)) {
> ? ? ? ? ? ? ? ?ret = PTR_ERR(uap->pinctrl);
> - ? ? ? ? ? ? ? goto unmap;
> + ? ? ? ? ? ? ? goto out;
> ? ? ? ?}
> ? ? ? ?uap->pins_default = pinctrl_lookup_state(uap->pinctrl,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PINCTRL_STATE_DEFAULT);
> @@ -1915,7 +1917,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> ? ? ? ?uap->clk = clk_get(&dev->dev, NULL);

Maybe you can use devm_clk_get here too.
