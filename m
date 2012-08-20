From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 20 Aug 2012 20:01:51 +0200
Subject: [PATCH 04/11] pinctrl: mvebu: add pinctrl driver for Armada 370
In-Reply-To: <20120820193622.4e539451@skate>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYNZar7865-T12J37h3AWA9-8R1R5tymuOhaB0b3ddEAA@mail.gmail.com>
 <50326A60.1070007@gmail.com> <20120820193622.4e539451@skate>
Message-ID: <50327B8F.3050503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 07:36 PM, Thomas Petazzoni wrote:
> In order to keep the consistency with other SoC families, maybe we can
> split the 370 and XP options in two separate MACH_ARMADA_370 and
> MACH_ARMADA_XP. So, in the ideal world, once all Marvell EBU SoCs are
> converted to DT+mach-mvebu, we should have:
>
>   *) arch/arm/Kconfig defines MACH_MVEBU
>
>   *) arch/arm/mach-mvebu/Kconfig defines MACH_KIRKWOOD, MACH_DOVE,
>      MACH_MX78X00, MACH_ARMADA_370, MACH_ARMADA_XP, MACH_ORION5X
>
> Then, an user is free to build a single kernel image that supports all,
> or a selection of the supported Marvell EBU SoCs.
>
> Would that be ok with you?

Yes!

> If that's fine with you, then I would prefer if we keep the single
> MACH_ARMADA_370_XP symbol for now, so that your pinctrl set of patches
> does not depend on something else. We would do the small Kconfig option
> refactoring as a follow-up set of patches. Thoughts?

Despite any objections, I will remove all arch/arm/*/Kconfig patches
from pinctrl patch set.

Sebastian
