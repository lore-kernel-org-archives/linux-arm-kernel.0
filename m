From: olof@lixom.net (Olof Johansson)
Date: Wed, 17 Oct 2012 10:26:24 -0700
Subject: [PATCH] ARM: U300: bump IRQs to offset 32
In-Reply-To: <1350491679-32685-1-git-send-email-linus.walleij@stericsson.com>
References: <1350491679-32685-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOesGMjk_97+zhsQTczYLJ0ztL2vHxsGp5cNOef2ArBR=zTc5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 17, 2012 at 9:34 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

[..]
> -#define IRQ_U300_INTCON0_START         1
> -#define IRQ_U300_INTCON1_START         33
> +#define IRQ_U300_INTCON0_START         32
> +#define IRQ_U300_INTCON1_START         64
[...]
> +#define IRQ_U300_IRQ0_EXT              32
> +#define IRQ_U300_IRQ1_EXT              33

Since you're touching these lines anyway, it might be nice to just
have them as a (base + offset) define instead (if you already had
that, this patch would have been a three-liner).

But if you truly think this is the last time you're touching these
lines to renumber them all, then:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
