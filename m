From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 13 Jun 2018 22:53:41 +0200
Subject: [PATCH V3] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <CAMuHMdUmqAWHFoM5tRJA+FoH59J8L3z0BMKVO-FEv4RQbokJyg@mail.gmail.com>
References: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXG6mMfFTz+fdZQ53hLxYgVZPmsGpaRri8TesiruUNYUg@mail.gmail.com>
 <fa4f843b-ae9d-fac2-77e2-b3ac1116f916@gmail.com>
 <CAMuHMdXw146fwm0tHS7CBAofDAgRgDD2tNqgEJwzx0Jm1xKCyw@mail.gmail.com>
 <967b800e-c935-aa35-da5a-ca3672fd18c2@gmail.com>
 <CAMuHMdVJ+ad-kr0iYuoaH3chJ49_g6yjEb8PHmTpwjFdYcG4=Q@mail.gmail.com>
 <47e87deb-a7a8-4780-53b5-4e4ed6e1bac3@gmail.com>
 <CAMuHMdXJEC8HbuB5+YHMLjZy9GfCYyXmGTk0TXkoAxLhxTOJyA@mail.gmail.com>
 <6864ed2c-39ac-615d-f38e-b28c3647e451@gmail.com>
 <CAMuHMdUSmpkwNUV+x9oGjsJdN42XBuUBNd0vSn=bgyX+953YOw@mail.gmail.com>
 <3eda9da7-e26e-3e77-1040-9febe3b18abb@gmail.com>
 <CAMuHMdUmqAWHFoM5tRJA+FoH59J8L3z0BMKVO-FEv4RQbokJyg@mail.gmail.com>
Message-ID: <c86c2ae6-21de-391e-a23f-b70976e86852@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2018 01:28 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

[...]

>>>> But wait, since we control which machines this code runs on , can't we
>>>> assure they have valid DTs ? This situation with invalid DT starts to
>>>> look a bit hypothetical to me.
>>>
>>> That assumes you keep the list of machines to check, and don't want to fix the
>>> issue automatically when detected (on any R-Car Gen2 or RZ/G1 platform, so
>>> you still need to check for r8a779[0-4] and r8a774[23457]).
>>
>> Yes, I want to keep a list of machines to check, to be _sure_ some
>> machine doesn't randomly blow up.
> 
> Just checking for the presence of a "renesas,irqc" node should be sufficient.

How so? Any other R-Car machine can have the irqc node too. That's
fragile at best.

> Using that node would also get rid of the hardcoded IRQC_BASE address.
> Note that the code assumes IRQ2. If another IRQ is used, that won't harm
> much though (as in: if it didn't blow up before, it won't blow up now).

We could/should fix up the irqc detection though.

>>> Anyway, as we care about booting old DTBs on new kernels (for a while), we
>>> have a few more release cycles to bikeshed ;-)
>>
>> I was about to ask if this patch then makes any sense or not.
> 
> Sure. Less hard-coding is always better.
> Especially if it means we can make it work on more machines automatically :-)

I prefer to be in control of that.

-- 
Best regards,
Marek Vasut
