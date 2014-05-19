From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 May 2014 10:23:38 -0700
Subject: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
In-Reply-To: <537A3544.1050307@linaro.org>
References: <5373C8E8.6040208@ti.com> <5373CBB9.40506@linaro.org>
 <5373DD94.8030208@ti.com> <5374F35E.5040900@ti.com>
 <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com>
 <5375079E.3060305@ti.com> <537615EA.3020809@ti.com>
 <20140516212942.GK12881@atomide.com> <537A3544.1050307@linaro.org>
Message-ID: <20140519172338.GJ4849@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [140519 09:46]:
> On 05/16/2014 11:29 PM, Tony Lindgren wrote:
> >
> >And just to recap, this problem can be reproduced with current
> >Linux next with omap2plus_defconfig with CONFIG_CPU_IDLE enabled. The
> >system should hang during the boot at some point.
> 
> I can take the time to investigate a bit more but not right now. What is
> your deadline before committing the reverts ?

Well we do have several automated build and boot systems failing
because of this with multi_v7_defconfig. And users are complaining,
see this report from Tobias Jakobi:

https://bugzilla.kernel.org/show_bug.cgi?id=75421

It seems that doing the revert is not enough based on the
page above.

I'd prefer we'd fix this issue properly for sure, it seems that
we're not quite understanding what's going on. And this might
hit other platforms too when they start implementing deeper
PM idle states in the mainline kernel.

Regards,

Tony
