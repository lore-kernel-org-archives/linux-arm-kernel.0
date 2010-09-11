From: rabin@rab.in (Rabin Vincent)
Date: Sat, 11 Sep 2010 11:07:43 +0530
Subject: [PATCH] MMCI: use _cansleep GPIO functions
In-Reply-To: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
References: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 10, 2010 at 2:01 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> - ? ? ? ? ? ? ? status = !!gpio_get_value(host->gpio_cd) ^ plat->cd_invert;
> + ? ? ? ? ? ? ? status = gpio_get_value_cansleep(host->gpio_cd) ^
> + ? ? ? ? ? ? ? ? ? ? ? plat->cd_invert;

Why do you remove the double negation?  gpio_get_value*()
can return non-zero values, and we need to make it 1 for the
inversion xor to work.
