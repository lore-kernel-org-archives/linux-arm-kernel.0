From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 15 Nov 2012 19:38:59 +0530
Subject: [PATCH 02/14] ARM: SPEAr13xx: DT: Add spics gpio controller nodes
In-Reply-To: <CACRpkdaJ2kCYfSP=xCRQAG2wDnkMKX9fey+ByhDDiOS==u+XwA@mail.gmail.com>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <58a7d91cab20b924784fb5a09e16ca08e6f13318.1352608333.git.viresh.kumar@linaro.org>
 <CACRpkdZkgmLF8TxFCZSubP+g+6_ofZugArKtE9=dYTZfemstrw@mail.gmail.com>
 <CAKohpon=AVGZmR_cwUZ4=buw0kr3JVtXh51BtXteWkJ7E-f_bQ@mail.gmail.com>
 <CACRpkdaJ2kCYfSP=xCRQAG2wDnkMKX9fey+ByhDDiOS==u+XwA@mail.gmail.com>
Message-ID: <CAKohpok7-iBCoYk+aAXZPsOODyh6tp2nutC+6wYOot-bK3=wkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2012 19:36, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> >         ahb {
>>> > +               spics: spics at e0700000{
>>> > +                       compatible = "st,spear-spics-gpio";
>>> > +                       reg = <0xe0700000 0x1000>;
>>> > +                       st-spics,peripcfg-reg = <0x3b0>;
>>> > +                       st-spics,sw-enable-bit = <12>;
>>> > +                       st-spics,cs-value-bit = <11>;
>>> > +                       st-spics,cs-enable-mask = <3>;
>>> > +                       st-spics,cs-enable-shift = <8>;
>>> > +                       gpio-controller;
>>> > +                       #gpio-cells = <2>;
>>> > +               };
>>> > +
>>>
>>> Are these bindings documented?
>>
>> The main patch waiting for ur comments is 1/14.
>
> I seldom comment on individual DT bindings, I just want
> to know that they're there :-)

Its not that simple. You are required to Ack it, as we have added it in
drivers/pinctrl/spear because we are controlling pins here :)

--
viresh
