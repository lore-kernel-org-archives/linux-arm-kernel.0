From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 5 Sep 2010 11:14:37 +0200
Subject: [PATCH] ARM: PL330: Accept revisions of the dmac
In-Reply-To: <1283502656-15445-1-git-send-email-jassisinghbrar@gmail.com>
References: <1283502656-15445-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <AANLkTimC5Ru-cTGVynnCu2NntHrHa9pB1HSGWEEJNZT7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/3 Jassi Brar <jassisinghbrar@gmail.com>:

> -#define PERIPH_ID_VAL ?((PART << 0) | (DESIGNER << 12) \
> - ? ? ? ? ? ? ? ? ? ? ? ? | (REVISION << 20) | (INTEG_CFG << 24))
> +#define PERIPH_ID_VAL ?((PART << 0) | (DESIGNER << 12))
>
> ?#define PCELL_ID_VAL ? 0xb105f00d

Jassi, this kind of macros already exist in <linux/amba/bus.h>
can't you just #include that and use these instead?

Notice that you have the ID encoded in drivers/dma/pl330.c as
well so can you also update the mask/add a few ID:s to
pl330_ids[] in that file when you change this?

Yours,
Linus Walleij
