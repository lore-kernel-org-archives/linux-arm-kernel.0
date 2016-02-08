From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 Feb 2016 18:01:12 +0530
Subject: [PATCH RFC] Add cpufreq support
In-Reply-To: <2425296.hvcP5NDLXy@wuerfel>
References: <56B4D4BE.2040008@free.fr> <3308645.nrPBoahQ2V@wuerfel>
 <20160207122212.GA3808@vireshk> <2425296.hvcP5NDLXy@wuerfel>
Message-ID: <20160208123111.GE8294@vireshk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-02-16, 13:24, Arnd Bergmann wrote:
> Whatever you want to do in drivers/cpufreq that keeps this out of arch/arm/
> 
> As I have said numerous times, there is absolutely no point in having a
> platform device for this, but if you insist on having one

No, I don't insist on that. I just hate it.

But the problem was that we never agreed to a way, by which we could
have probed cpufreq-dt. We were talking about compatible string from
'opp-v2' earlier, but that was soon discarded.

> just write one
> file that has an early_initcall() function and move all the code creating
> those devices in there for platforms using DT, e.g. by matching on the
> root compatible string the same way the platform code does today.
>
> For new platforms, please come up with a way to not need that and create
> a generic binding that anyone can follow.

Do you have any suggestions ?
- We aren't allowed to (re)use opp-v2 compatibility string
- We can't add a DT node for virtual device - cpufreq

What else can be done ?

-- 
viresh
