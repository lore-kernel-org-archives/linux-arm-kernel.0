From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Wed, 15 May 2013 23:20:08 +0200
Subject: [RFC 2/4] dma: add dmaengine driver for Samsung s3c24xx SoCs
In-Reply-To: <201305152231.52423.heiko@sntech.de>
References: <201305111330.05046.heiko@sntech.de>
 <201305111331.25405.heiko@sntech.de>
 <CACRpkdaT195McX9NeccJYpmWbuYK-AZUTHr9AXKHnJdkf+Qzuw@mail.gmail.com>
 <201305152231.52423.heiko@sntech.de>
Message-ID: <5193FC08.5040002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 10:31 PM, Heiko St?bner wrote:
>>> +       BUG();
>> >
>> >  Isn't that a bit nasty. This macro should be used with care and we
>> >  should recover if possible. dev_err()?
>
> runtime_config already denies any settings not in the 1,2 or 4bytes range -
> the default-part should therefore never be reached. So if any other value
> magically appears in the register and triggers the default-part, something is
> seriously wrong. So my guess is, the BUG might be appropriate.
>
> On the other hand the whole default+BUG part could also simply go away, for
> the same reasons.

IMHO BUG() is not needed at all. As Linus suggested dev_err() is such case
or WARN_ON() would be more appropriate. This has been discussed in the past
extensively, not sure if you are aware of the other Linus' opinion on
BUG()/BUG_ON() proliferation: https://lkml.org/lkml/2012/9/27/461

Regards,
Sylwester
