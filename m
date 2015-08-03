From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Aug 2015 10:19:12 +0200
Subject: [RESEND PATCH] pinctrl: at91: fix null pointer dereference
In-Reply-To: <1438069696-25303-1-git-send-email-ludovic.desroches@atmel.com>
References: <20150715133048.GD14886@odux.rfo.atmel.com>
 <1438069696-25303-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdZnL7g6O1CgBG0gZ525QZs43tvzTx-1NXZ2HR6cQXbyDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 9:48 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> From: David Dueck <davidcdueck@googlemail.com>
>
> Not all gpio banks are necessarily enabled, in the current code this can
> lead to null pointer dereferences.
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

This v2 version applied for fixes with v3.18+ stable tag.

Yours,
Linus Walleij
