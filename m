From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 15 Oct 2015 16:30:09 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <561FC681.2040809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 15/10/15 11:20, Linus Walleij wrote:
> The Juno motherboard has a NOR flash on the motherboard, enable
> this to be accessed with the CFI flash driver. Results after
> enabling MTD, MTD_CFI, MTD_PHYSMAP, MTD_PHYSMAP_OF,
> MTD_CFI_INTELEXT:
>

Just a note on this: we can't enable these when CPUIDLE is enabled as
the firmware assumes the flash is always in read mode while Linux leaves
NOR flash in "read id" mode after initialization.

So until the firmware is ready to handle that, we can't enabled both
on Juno. We had same issue even on TC2. I will follow up internally to
see if we can fix on Juno at-least.

So until then, keep an eye on this if someone complains about boot issue
with both MTD and CPUIDLE enabled.

-- 
Regards,
Sudeep
