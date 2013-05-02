From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 2 May 2013 18:21:30 +0200
Subject: [PATCH 20/23 v2] ARM: u300: add SPI PL022 to the device tree
In-Reply-To: <201305021726.49729.arnd@arndb.de>
References: <1367485952-6212-1-git-send-email-linus.walleij@stericsson.com>
 <201305021726.49729.arnd@arndb.de>
Message-ID: <CACRpkdbO1H4tpRG5rABVZDDOP0uHFs2Fc4+66TD9kyZauUrkLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 2, 2013 at 5:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 02 May 2013, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This registers the PL022 PrimeCell from the U300 device
>> tree. We make a new copy of the platform data for the
>> device tree boot path, as the old platform data is in an
>> older file which will be going away.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Why do you need both the platform data and the DT description?

This is because the device-tree DMA support for PL022 has
not yet been merged upstream, so it still has to come from
platform data instead.

If/when there is a branch in ARM SoC that has that patch in place
(and I remember reviewing and ACKing it) I can rebase on that
and drop the platform data.

The same goes for PL011 and MMCI platform data actually...

Yours,
Linus Walleij
