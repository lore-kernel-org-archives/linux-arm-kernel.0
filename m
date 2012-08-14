From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 12:44:37 +0200
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <201208140942.54773.arnd@arndb.de>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
 <201208140942.54773.arnd@arndb.de>
Message-ID: <CACRpkdYbOBEPNbCdfi+=gupdqS8_7t7MpOgXs7VCVTs8Y3j_mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 11:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 14 August 2012, Linus Walleij wrote:
>> On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > +int db8500_irq_get_virq(int irq);
>>
>> And I'm sceptic about this business. Why isn't this physical-to virtual
>> mapping business confined to the core MFD driver? But enlighten me.
>
> Traditionally, an MFD would add an offset to the local IRQ number
> to put the VIRQ into the IRQ resource, but this doesn't work when
> you have domains other than legacy.

Yes but I think I saw this other patch set from Lee, hitting
irqdomain, OF and MFD to actually fix this ... or did I get
it wrong?

Yours,
Linus Walleij
