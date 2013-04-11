From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Apr 2013 19:35:21 +0200
Subject: [PATCH] GPIO: gpio-generic: Remove kfree() from bgpio_remove call
In-Reply-To: <1365701002-17292-1-git-send-email-shc_work@mail.ru>
References: <1365701002-17292-1-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdZ8X1O7O+wVSYR6Q_e9QBV42707SO-Mx+dfUPjpO=mYvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 7:23 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

> Memory for basic-mmio-gpio driver is allocated by resource managed
> function, so using kfree() call in bgpio_remove is wrong.
> This patch eliminates this kfree() call.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

So I think the patch is correct but the commit message is wrong.

It is not certain at all that bgpio is resource managed, but the point
of the patch should be that it's up to the driver using it to allocate
and free its struct bgpio_chip, after calling this function.

A quick glance on the consumers gives at hand that this is the case
for all consumers, so I took the liberty to update the commit
message and apply it...

Yours,
Linus Walleij
