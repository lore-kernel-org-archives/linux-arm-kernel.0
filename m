From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Jul 2018 21:43:23 +0200
Subject: [PATCH] dma: ste_dma40: Remove VLA usage
In-Reply-To: <CAMuHMdUWATshtf8PX+QxwrOHaXt60j2e_GYx=L-UbWjYVL80yA@mail.gmail.com>
References: <20180629185107.GA37488@beast>
 <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
 <CACRpkdYbmu_Y6N1G3M3q3M=3ZaECFdgije6Qgwoo6qra4g06_A@mail.gmail.com>
 <CAMuHMdUWATshtf8PX+QxwrOHaXt60j2e_GYx=L-UbWjYVL80yA@mail.gmail.com>
Message-ID: <CAK8P3a13um6=hNz1EFNTCPA5Be2nH8Y1bD26cOry3GmFw8astA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 5:28 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Jul 2, 2018 at 4:22 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Jun 29, 2018 at 11:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> > - Nobody uses this driver in practice, as the hardware platform
>> >   was a dead end
>>
>> Depends what you mean with dead end.
>>
>> The hardware was deployed in a few million handsets from Samsung
>> and Sony.
>>
>> Some have been picked up as targets for PostmarketOS:
>> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_S_Advance_(samsung-i9070)
>> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_SIII_mini_(samsung-i8190)
>>
>> So it is no more dead end than anything else discontinued, and it
>> has a living community who want it suppored by the mainline
>> kernel if possible.

I meant that when ST-Ericsson imploded, STMicroelectronics inherited the
SoC family but never did any follow-up chips. We only really ever supported the
original U8500 but not the later models (which have partial support), and that
is very unlikely to change, so all the devices that can run this
driver are already
known. This is only relevant because the dynamic allocation size depends on
the chip model.

> Mixup with SuperH-based ST40?

No, but I wouldn't be surprised to find an ST40 inside the D40 engine ;-)

      Arnd
