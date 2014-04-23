From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 15:54:35 +0200
Subject: [PATCH v3 7/7] ARM: sunxi: update the default ARCH_NR_GPIO for
 sunxi arch
In-Reply-To: <201404221620.19519.arnd@arndb.de>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-8-git-send-email-boris.brezillon@free-electrons.com>
 <CACRpkdYT9HvG6dOVOEnBSNhRt847tdCsAU6E_dZLdFQEHntpKg@mail.gmail.com>
 <201404221620.19519.arnd@arndb.de>
Message-ID: <CACRpkdZAd5SqeCg7XsjXMbYxD+RoriV6x6YMR=59Aon=S7cDnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 4:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> Patch applied, and grrrr we need to get rid of these static #gpios defines
>> in the long run.
>
> Yes, that would be nice. I guess the gpio-descriptor framework should
> have solved this, but we can't move everything over to that soon, right?

Not really, it has to happen platform by platform.

I did consider putting all the GPIO descriptors into a radix and
use that internally in gpiolib, but that wasn't easy to do
when I tried it, maybe I just thought backwards.

I would appreciate if drivers for new archs like arm64 would
use only GPIO descriptors from day one. Also if new drivers
only apply a an entirely new machine even. They should just
use descriptors.

Yours,
Linus Walleij
