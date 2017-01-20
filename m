From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Jan 2017 10:16:06 +0100
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170119154946.ozuxixafsoqblxvw@lukather>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <CACRpkdbU=DeZx4a8Ax8hh6iv0n1c-6XKVrts1ff=-_E5=_dc8A@mail.gmail.com>
 <20170119154946.ozuxixafsoqblxvw@lukather>
Message-ID: <CACRpkdadBe8Ty6N4DzXpmkLuTxeAGb6bNaZpygvh99cRUZ6y+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 4:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

>> > +Optional properties:
>> > +  - interrupt-names:
>> > +    * pmu: Power Management Unit interrupt, if implemented in hardware
>>
>> On the MALI-400 MP in the ST-Ericsson DB8500 we have an additional interrupt
>> called "Mali400 combined". This is simply the HW designer's
>> doing an OR over all the 4 IRQ lines. Is this useful to define in the
>> bindings? Then it should be an optional
>
> Do you still have all the other interrupts, or just this combined interrupt?

We have the others too, I guess some HW engineer just thought it'd
be nice to have the combo.

> Either way, that should definitely be part of the binding, but maybe
> as part of the vendor specific binding below?

OK.

>>  * combined: all lines OR:ed together (if available)
>>
>> Also you are defining "resets" below in the examples, should
>> this be listed as an optional property?
>
> In my mind, this is not optional. For some platforms, it's mandatory,
> and for some, it's not there at all. IMO, this should really be a
> mandatory property, but only for the compatibles that use it (just
> like the clocks are).

OK.

Yours,
LInus Walleij
