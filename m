From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 11 Feb 2017 12:17:17 +0100
Subject: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
In-Reply-To: <3236035.PSA6VtheyS@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <CACRpkdbrys49Yv5fJ_te2H1mEUqquc1jn2dP-uvkdLixFbtYFA@mail.gmail.com>
 <alpine.LNX.2.00.1702061038590.7077@T420s> <3236035.PSA6VtheyS@wuerfel>
Message-ID: <CACRpkdah04ZaRU52Gr6L=qmW57N6XOgZeHYNDzB2GcSH+B3DXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, February 6, 2017 10:55:03 AM CET Hans Ulli Kroll wrote:
>>
>> from my IB 4220 sources.
>>
>> #define IRQ_PCI_INTA                                   PCI_IRQ_OFFSET + 0
>> #ifndef CONFIG_DUAL_PCI
>> #define IRQ_PCI_INTB                                   PCI_IRQ_OFFSET + 1
>> #define IRQ_PCI_INTC                                   PCI_IRQ_OFFSET + 2
>> #define IRQ_PCI_INTD                                   PCI_IRQ_OFFSET + 3
>> #else
>> #define IRQ_PCI_INTB                                   27
>> #define IRQ_PCI_INTC                                   28
>> #define IRQ_PCI_INTD                                   29
>> #endif
>>
>> CONFIG_DUAL_PCI is never used
>> IRQ_PCIB - IRQ_PCID or IRQ_PCI_INTB - IRQ_PCI_INTD are also never used.
>
> The source code that Linus quoted earlier had references to
> 'IRQ_PCI_INTA +n' though, which is basically the same thing.

There is essentially two versions of the IP block, one which has
a cascaded interrupt controller in the PCI host bridge, and one
named "dual PCI" that has dedicated IRQs for PCIA, B, C, D on
the primary interrupt controller.

I'll try to codify it into the driver so it's clear how this works on the
two variants.

I'm also pretty sure this is a faraday IP block and not something
from Storlink/Storm/Cortina, so I will rename the compatible strings
etc reflecting that.

Yours,
Linus Walleij
