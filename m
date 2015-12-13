From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sun, 13 Dec 2015 22:52:12 +0100
Subject: [PATCH v2] spi: dts: sun4i: Add support for inter-word wait
 cycles using the SPI Wait Clock Register
In-Reply-To: <20151213210719.GC19456@lukather>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
 <20151213210719.GC19456@lukather>
Message-ID: <CAGNoLaMe1wmo5cz1D0LXVc2uTatG+t4LEeipHJEmozByg_OwRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-13 22:07 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
[...]
>> There is one review comment that I didn't address: Rob Herring suggested
>> that this should be in the core-binding rather than in sun4i. I checked
>> many of the hardware manuals of other SPI drivers and it looks to me like
>> this hardware based inter-word delay is a feature that not many SPI
>> controllers offer. And the SPI core currently has no way to control an
>> inter-word delay, only inter-message. So I would like to propose this again
>> as a sun4i binding, as it targets a sun4i (or sunxi?) specific hardware
>> feature.
>
> Only a few of them justify to have this in the framework. There's a
> bunch of controllers that support such a feature, and it definitely
> belongs in the core.
>
> The point of the framework is not to be the least common denominator,
> it's about having as much code in common as possible, and it
> definitely falls into that category.

Ok, now I understand. I did indeed think that the SPI core is more
like a least common denominator. So I will add the property to the
spi-core binding, as initially requested by Rob and send a v3.

Thanks for the review, Maxime!

Marcus
