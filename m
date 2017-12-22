From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Dec 2017 08:09:53 +0100
Subject: [PATCH v2] i2c/ARM: davinci: Deep refactoring of I2C recovery
In-Reply-To: <CACRpkdYhtrVKk36cza_RUysjp_ZYvT5D0nCGdG3K9=SGsdJNLA@mail.gmail.com>
References: <20171220121749.12064-1-linus.walleij@linaro.org>
 <CAK8P3a2+oa+yzAcpmB+YMuCYMxtFdYknETUtKShZX56G6m76Gg@mail.gmail.com>
 <CACRpkdYhtrVKk36cza_RUysjp_ZYvT5D0nCGdG3K9=SGsdJNLA@mail.gmail.com>
Message-ID: <CAK8P3a3rUpUvfW_kC9pwoov_sbC72y1XjU5HXDimqbAgbLw7kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 11:30 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Dec 21, 2017 at 4:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Dec 20, 2017 at 1:17 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> Alter the DaVinci GPIO recovery fetch to use descriptors
>>> all the way down into the board files.
>>>
>>> Cc: arm at kernel.org
>>> Cc: Kevin Hilman <khilman@kernel.org>
>>> Cc: Keerthy <j-keerthy@ti.com>
>>> Cc: Sekhar Nori <nsekhar@ti.com>
>>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>>> Tested-by: Sekhar Nori <nsekhar@ti.com>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> ChangeLog v1->v2:
>>> - Change gpiochip name from gpio_davinci.0 to gpio_davinci, simply.
>>
>> This seems to clash with "i2c: davinci: Add PM Runtime Support", please
>> rebase on top of v4.15-rc and resend.
>
> Strange, where do you see this problem?
>
> I just applied the patch on top of Wolfram's for-next
> branch and it worked like a charm. It has the PM Runtime patch
> underneath and all.

I looked at v4.15-rc4, but haven't analyzed further.

        Arnd
