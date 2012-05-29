From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 May 2012 09:47:54 +0800
Subject: [PATCH] PINCTRL: SiRF: add CSR SiRFprimaII GPIO driver depending
 on pinmux APIs
In-Reply-To: <CAGsJ_4yz=-szdaLWgKbTHkZtO+zqZvM35gXCHBprto=odjs41w@mail.gmail.com>
References: <1337670845-14572-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdZOTZaVp6rfuQvZaQyk0+zxeAjwHryBMYY-C1WVABaLLA@mail.gmail.com>
 <CAGsJ_4zknQjNK6-T7+av1N=7gijZ821keM=qaDEJZ9zOfnLhkw@mail.gmail.com>
 <CACRpkdb=00UP3NaBj4NhVy0wYhwkqqRB5e3Gid5hcpVhxH0wYw@mail.gmail.com>
 <CAGsJ_4yz=-szdaLWgKbTHkZtO+zqZvM35gXCHBprto=odjs41w@mail.gmail.com>
Message-ID: <CACRpkdZuge1vJquaSoYjk+zFEU+yafSG3L4UhRDhAZww73-RZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 8:20 AM, Barry Song <21cnbao@gmail.com> wrote:
> 2012/5/29 Linus Walleij <linus.walleij@linaro.org>:
>> On Mon, May 28, 2012 at 11:03 PM, Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> here i splitted into two files just for viewing, and at the same time,
>>> i remap the same memory twice in pinctrl-sirf.c and gpio-sirf.c. they
>>> share same memory area.
>>
>> Hmmmm.... but do they ever write into the same registers?
>
> they share the same IOMEM area, but gpio set registers have different
> offset with pinmux. is there any difference between writing same
> registers and writing different registers? mainly, they are from the
> same hardware controller.

I don't really have an opinion on this, you can do it either way.

It's nice to split the files into separate drivers for smaller files and
cleanly cut devices.

It's also nice to have it all in one file so you can get the whole picture
of how the hardware works.

Usually the problem has been to cross-reference the GPIO ranges
from another driver, like adding the struct gpio_chip * to the ranges,
but it seems you don't have this problem in your driver? If you think
you will run into this problem, merge it into the pinctrl driver to
save yourself from lots of trouble.

Maybe someone else has some ideas?

Yours,
Linus Walleij
