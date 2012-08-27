From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Aug 2012 16:46:45 -0700
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <20120825083811.GB7629@game.jcrosoft.org>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZ2__V06Eo8JH451Sup5Nw2jJXVOH2FOfZBp5nNYpCtbg@mail.gmail.com>
 <5034FC18.2090400@wwwdotorg.org>
 <CACQ1gAieByr5vMmyyCuGtS8AgnnRZPPhLZY8sKvwvcQYe5ieUA@mail.gmail.com>
 <50366D2B.4010807@wwwdotorg.org>
 <20120825083811.GB7629@game.jcrosoft.org>
Message-ID: <CACRpkdYWXZLNdgMhqoMZsaaszZ5Uz9pZ1EO=mrnuY5Der4O+Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 25, 2012 at 1:38 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 11:49 Thu 23 Aug     , Stephen Warren wrote:
>> On 08/23/2012 01:06 AM, Richard Genoud wrote:

>> > Let's take the PioA - peripheral B: 0xffe0399f
>> > From the documentation table 4-3, we can extract the column PIO
>> > Periperal B for all signals PA0-PA31:
>> ...
>> > Each time it's possible to mux a pin to the peripheral B function (ie
>> > when there's no "-----") the corresponding bit is set:
>> ...
>> > => this gives 0x399f
>>
>> Ah OK. It would be a good idea to briefly describe this process in the
>> binding document I think. I assume this property exists to avoid the
>> kernel driver having to contain tables for each Atmel device; the driver
>> is generic.
> Yeap I did this exactly for this
>
> I do not want to maintain such code for the whole bunch of at91
> and this way I add other SoC with just via dtsi without touching c code
>
> I think other driver should do so too

I'm following it now I think, after some discussion here at the kernel summit
I have come to the conclusion that the real problem with readability comes
from a shortcoming in the device tree compiler, that it cannot handle
macros and defines (no preprocessor) so it's currently hard to make
it more readable.

But that's not the implementers fault so I'm OK with this looking like
this for the moment.

Yours,
Linus Walleij
