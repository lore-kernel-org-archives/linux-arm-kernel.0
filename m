From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 18 Oct 2015 11:25:48 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <561FC681.2040809@arm.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
Message-ID: <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 5:30 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Me
>>  Results after
>> enabling MTD, MTD_CFI, MTD_PHYSMAP, MTD_PHYSMAP_OF,
>> MTD_CFI_INTELEXT:
>
> Just a note on this: we can't enable these when CPUIDLE is enabled as
> the firmware assumes the flash is always in read mode while Linux leaves
> NOR flash in "read id" mode after initialization.

Sorry I'm too unfamiliar with this lingo. Can you give me some detail
on what "read mode" and "read id" mode is all about?

> So until the firmware is ready to handle that, we can't enabled both
> on Juno. We had same issue even on TC2. I will follow up internally to
> see if we can fix on Juno at-least.

Sounds like something that should be fixed for all Versatile
Express that have cpuidle?

Yours,
Linus Walleij
