From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 8 Oct 2011 17:37:36 +0800
Subject: [PATCH 2/2] pinmux: add a driver for the U300 pinmux
In-Reply-To: <1317629883-13582-1-git-send-email-linus.walleij@stericsson.com>
References: <1317629883-13582-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4wJogkvhoJ0JNJGbv9FvaA7zHxFKRwvkXdY0g5SbLXuJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void __init u300_pmx_dumpregs(struct u300_pmx *upmx)
> +{
> + ? ? ? u16 regval;
> + ? ? ? int i;
> +
> + ? ? ? for (i = 0; i < ARRAY_SIZE(u300_pmx_registers); i++) {
> + ? ? ? ? ? ? ? regval = readw(upmx->virtbase + u300_pmx_registers[i]);
> + ? ? ? ? ? ? ? dev_info(upmx->dev, "PMX%u: 0x%04x\n", i, regval);
> + ? ? ? }
> +}
> +

is this a debug information or do you want it to be in mainline?

-barry
