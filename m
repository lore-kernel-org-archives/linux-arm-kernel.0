From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Feb 2016 13:34:13 +0100
Subject: [PATCH RFC] Add cpufreq support
In-Reply-To: <20160208123111.GE8294@vireshk>
References: <56B4D4BE.2040008@free.fr> <2425296.hvcP5NDLXy@wuerfel>
 <20160208123111.GE8294@vireshk>
Message-ID: <45004963.Im3DmqJ5ez@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 18:01:12 Viresh Kumar wrote:
> On 08-02-16, 13:24, Arnd Bergmann wrote:
> > Whatever you want to do in drivers/cpufreq that keeps this out of arch/arm/
> > 
> > As I have said numerous times, there is absolutely no point in having a
> > platform device for this, but if you insist on having one
> 
> No, I don't insist on that. I just hate it.
> 
> But the problem was that we never agreed to a way, by which we could
> have probed cpufreq-dt. We were talking about compatible string from
> 'opp-v2' earlier, but that was soon discarded.
> 
> > just write one
> > file that has an early_initcall() function and move all the code creating
> > those devices in there for platforms using DT, e.g. by matching on the
> > root compatible string the same way the platform code does today.
> >
> > For new platforms, please come up with a way to not need that and create
> > a generic binding that anyone can follow.
> 
> Do you have any suggestions ?
> - We aren't allowed to (re)use opp-v2 compatibility string
> - We can't add a DT node for virtual device - cpufreq
> 
> What else can be done ?

Maybe add a opp-v3 compatible string? I really don't care what you
match on, as long we don't need any code in arch/arm/ to create a
device we don't need.

Don't add the device to DT, we really don't want that. If there
is too much opposition to looking at the cpus nodes in the initcall,
start with a whitelist for known machines, that at least keeps the
existing behavior.

	Arnd
