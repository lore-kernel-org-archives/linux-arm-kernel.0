From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Dec 2011 19:02:42 +0100
Subject: [RFC PATCH v2 3/4] ARM: imx6q: using pinmux subsystem
In-Reply-To: <1323878622-26602-4-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-4-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdZhj2cqPL4yt+Xg7vy4jg-eauNzZFBUw2aSfvAauTqP0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 5:03 PM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shanw.guo@freescale.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> +static struct pinmux_map imx6q_pinmux_map[] = {
> + ? ? ? PINMUX_MAP_PRIMARY("usdhc4", "sd4", "219c000.usdhc"),
> +};
> +
> ?static void __init imx6q_init_machine(void)
> ?{
> ? ? ? ?of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -
> + ? ? ? pinmux_register_mappings(imx6q_pinmux_map,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(imx6q_pinmux_map));
> ? ? ? ?imx6q_pm_init();
> ?}

So ideally this bit of code should also go into the device tree
and we should add a DT hook inside drivers/pinctrl/pinmux.c

Please make a patch for this if you have a clear idea on how
it should work!

Yours,
Linus Walleij
