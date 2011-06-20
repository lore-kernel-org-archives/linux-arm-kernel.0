From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Jun 2011 09:25:30 +0100
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <4DFB8E20.60802@gmail.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de> <4DFB8E20.60802@gmail.com>
Message-ID: <4DFF03FA.8030906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/11 18:25, Rob Herring wrote:
> Arnd,
> 
> On 06/17/2011 10:07 AM, Arnd Bergmann wrote:
>> On Thursday 16 June 2011, Marc Zyngier wrote:
>>> Patches against next-20110615 + my earlier GIC-PPI series. Tested on
>>> VExpress, PB11MP, Pandaboard, Tegra Harmony and Exynos4 SMDK-v310.
>>>
>>> Thomas and Arnd cc-ed on the whole series, as this could be
>>> consolidation material.
>>
>> Very nice stuff. Should we take this all in one branch in the arm-soc tree,
>> pending Acks from the subarch maintainers?
>>
>> We could also push it through the individual subarch branches, but my feeling
>> is that would be more work.
>>
> 
> If this is the direction to go, then there are a lot of other timers
> that can be moved besides just local timers. But Russell didn't really
> like the shmobile patches for early platform devices which this relies
> on. So we should get agreement on the small bit of infrastructure needed
> first, then start moving individual timers.

I'm open to suggestions. Should the early platform infrastructure be
flagged as unsuitable, I'd be happy to switch to something else, as long
as it is minimal, and does not create another ARM-specific API (been
there, done that...).

> Also, device tree support for early platform devices would be useful for
> this.

Indeed.

	M.
-- 
Jazz is not dead. It just smells funny...
