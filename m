From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 11:23:48 +0200
Subject: [PATCH] ARM: ux500: avoid warning in ux500_read_asicid
In-Reply-To: <2475820.dXNmmAuTaP@wuerfel>
References: <2475820.dXNmmAuTaP@wuerfel>
Message-ID: <CACRpkdZapi-xERDkjNz03VOJFFga090xvdqUrHUdY+05GS4MdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 10:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> phys_addr_t may be 64 bit, which causes this harmless warning
> in ux500_read_asicid:
>
> arch/arm/mach-ux500/id.c: In function 'ux500_read_asicid':
> arch/arm/include/asm/io.h:159:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  #define IOMEM(x) ((void __force __iomem *)(x))
>                    ^
> arch/arm/mach-ux500/id.c:40:9: note: in expansion of macro 'readl'
>   return readl(IOMEM(UX500_VIRT_ROM + (addr & 0xfff)));
>
> We can solve this in a nicer way by making UX500_VIRT_ROM have a proper
> type to start with and calculating the address using pointer arithmetic.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Patch applied to ux500-core for v3.11, as it doesn't seem to
be a dangerous regression.

You'll get this back by pull request soon-ish.

Yours,
Linus Walleij
