From: olof@lixom.net (Olof Johansson)
Date: Sat, 4 Aug 2012 11:27:20 -0700
Subject: [GIT PULL][for 3.7] pull request from dt-mmp branch in pxa git
 tree
In-Reply-To: <CAN1soZy-FBmywNLn9a0yanx9ojfB-jnqzYyXwAYr6F1_Khvacg@mail.gmail.com>
References: <CAN1soZy-FBmywNLn9a0yanx9ojfB-jnqzYyXwAYr6F1_Khvacg@mail.gmail.com>
Message-ID: <CAOesGMgwX+Use1wGOhgMe=63F1u8vPrft=FvysYNY+EbsUO5Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looking at your branch more in detail now, and there's a few things I
would like to see changed. See below:


> Daniel Mack (9):
>       RTC: add DT bindings to pxa-rtc
>       MMC: pxa-mci: add DT bindings
>       MTD: pxa3xx-nand: add devicetree bindings
>       GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and pxa_irq_to_chip()
>       GPIO: gpio-pxa: fix devicetree functions
>       ARM: pxa: add devicetree code for irq handling
>       ARM: pxa3xx: skip default device initialization when booting via DT
>       ARM: pxa3xx: add generic DT machine code
>       ARM: pxa: add .dtsi files
>
> Haojian Zhuang (6):
>       pinctrl: append new pins and groups in pxa910
>       pinctrl: add pinconf support in pxa3xx
>       pinctrl: support dt in pxa series
>       pinctrl: append new groups of mmp2

None of these have acks from Linus Walleij. They should possibly even
be merged through his tree. If you need them in both trees, or if you
have dependencies on other changes done in this branch, then there's
two options:

* Create one branch that gets pulled into both pinctrl and arm-soc
trees, and we need to agree that neither of us will rebase it
* Collect acks from Linus W and ask him if it's OK that you merge
through arm-soc.

I also don't see any devicetree bindings documented for the PXA
pinctrl bindings?

There are also a bunch of other changes to the tauros2 code that is in
this branch but was not in the pull request. Some of code should
probably go in through Russell's tree since it touches core ARM code.


-Olof
