From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 19 Aug 2014 08:38:21 -0400
Subject: [PATCH] This adds a generic PWM framework driver for the PWM
 controller
In-Reply-To: <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
References: <20140818180316.31807.3445.stgit@studio>
 <20140818192318.GJ15297@lukather>
 <CAKON4OwzFDDXqCF4VNkUXXJLp3smrB6Axp_x=D47sjbpoNbe+g@mail.gmail.com>
 <20140818201929.GL15297@lukather>
 <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
Message-ID: <CAKON4OycUjDN-aPys-6hiFUHUdri12yE-=4J1LEAJVM1W3RD8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 8:11 AM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> On Mon, Aug 18, 2014 at 4:19 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Mon, Aug 18, 2014 at 03:53:08PM -0400, jonsmirl at gmail.com wrote:
>>> On Mon, Aug 18, 2014 at 3:23 PM, Maxime Ripard
>>> <maxime.ripard@free-electrons.com> wrote:
>>> > Hi,
>>> >
>>> > On Mon, Aug 18, 2014 at 02:03:16PM -0400, Jon Smirl wrote:
>>> >> found on Allwinner SoCs.x
>>> >>
>>> >> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>>> >
>>> > Is there any notable difference with Alexandre's driver?
>>> > https://lkml.org/lkml/2014/5/19/568
>>> >
>>> > If so, why didn't you posted incremental patches on top of his driver?
>>>
>>> Better A10 support.
>>
>> Better how?
>>
>>> And I wrote this one without know about his.
>>
>> So you're just require us to trash an already extensively reviewed
>> driver and start from scratch again?
>
> Forget mine then.
>
> Problems in the other one....
> 1) The math is not right in either patch. Selsinork has been checking
> mine with a scope and just found another math error in mine. The
> internal math needs to be done in picoseconds or round off errors mess
> up the high frequency outputs (24Mhz, 12Mhz, 8Mhz, ...).

Correct output table....
Neither driver has this right.

24Mhz  41.6ns period  1  - 62
12Mhz  83.3ns period 63 - 104
8Mhz  125ns  period 105 - 145
6Mhz  167ns period 146 - 187
4.8Mhz 208ns period 188 - 229
4Mhz   250ns period 230 - 270
3.4Mhz  292ns period 271 - 312
3Mhz   333ns  period 313 - 345




> 3) By-pass mode on the A20 is not implemented.
> 2) A10 is not correctly handled. Specifically the prescaler is
> different on the A10 vs A20.
>
>
>
>
>
>
>>
>> --
>> Maxime Ripard, Free Electrons
>> Embedded Linux, Kernel and Android engineering
>> http://free-electrons.com
>
>
>
> --
> Jon Smirl
> jonsmirl at gmail.com



-- 
Jon Smirl
jonsmirl at gmail.com
