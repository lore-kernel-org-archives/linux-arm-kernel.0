From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 17:58:14 +0100
Subject: [PATCH v2] i2c/ARM: davinci: Deep refactoring of I2C recovery
In-Reply-To: <CACRpkdY73GCcT24RsL3AGpGJDrwScHni1dYzSGm8rphZ8x0nZw@mail.gmail.com>
References: <20171220121749.12064-1-linus.walleij@linaro.org>
 <CAK8P3a2+oa+yzAcpmB+YMuCYMxtFdYknETUtKShZX56G6m76Gg@mail.gmail.com>
 <CACRpkdY73GCcT24RsL3AGpGJDrwScHni1dYzSGm8rphZ8x0nZw@mail.gmail.com>
Message-ID: <CAK8P3a1HmN+XP37pifVgpMZeehsfYFGGnjOCzqcLZ13TaqXnqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 5:48 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
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
> Since it is dependent on changes in the I2C tree and the
> current patch is based on linux-next I guess something
> got applied ahead of me, I guess I should just rebase
> on Wolfram's tree.

If it helps, you could merge the patch through his tree with my

Acked-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
