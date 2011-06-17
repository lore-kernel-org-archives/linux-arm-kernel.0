From: robherring2@gmail.com (Rob Herring)
Date: Fri, 17 Jun 2011 12:25:52 -0500
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <201106171707.23989.arnd@arndb.de>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de>
Message-ID: <4DFB8E20.60802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 06/17/2011 10:07 AM, Arnd Bergmann wrote:
> On Thursday 16 June 2011, Marc Zyngier wrote:
>> Patches against next-20110615 + my earlier GIC-PPI series. Tested on
>> VExpress, PB11MP, Pandaboard, Tegra Harmony and Exynos4 SMDK-v310.
>>
>> Thomas and Arnd cc-ed on the whole series, as this could be
>> consolidation material.
> 
> Very nice stuff. Should we take this all in one branch in the arm-soc tree,
> pending Acks from the subarch maintainers?
> 
> We could also push it through the individual subarch branches, but my feeling
> is that would be more work.
> 

If this is the direction to go, then there are a lot of other timers
that can be moved besides just local timers. But Russell didn't really
like the shmobile patches for early platform devices which this relies
on. So we should get agreement on the small bit of infrastructure needed
first, then start moving individual timers.

Also, device tree support for early platform devices would be useful for
this.

Rob
