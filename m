From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Jul 2015 14:48:09 +0200
Subject: [RESEND PATCH] pinctrl: at91: fix null pointer dereference
In-Reply-To: <1438069696-25303-1-git-send-email-ludovic.desroches@atmel.com>
References: <20150715133048.GD14886@odux.rfo.atmel.com>
 <1438069696-25303-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdaiwcTzxG=KqPZxk6ijLOE0PAh9ybkNqUYhkmAcQV40eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 9:48 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> From: David Dueck <davidcdueck@googlemail.com>
>
> Not all gpio banks are necessarily enabled, in the current code this can
> lead to null pointer dereferences.
>
> [   51.130000] Unable to handle kernel NULL pointer dereference at virtual address 00000058
(...)
>
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Boris Brezillon <boris.brezillon@free-electrons.com>
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
> ---
>
> This patch fixes a oops in the kernel because of a NULL pointer in a table.
> Having a NULL pointer in this table is the normal behavior if a PIO controller
> is not enabled. So this fix is not a quick and dirty hack, it's usual to skip
> an entry from a table if it is not filled.

Fair enough, better too many checks than too few.

Is this a regression to v4.2 that should go to stable or v4.3 material?

Yours,
Linus Walleij
