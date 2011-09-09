From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Sep 2011 17:06:39 +0200
Subject: [RFC PATCH v2 2/3] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <4E6A28F8.4070606@ti.com>
References: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
	<1315579616-27388-3-git-send-email-marc.zyngier@arm.com>
	<4E6A28F8.4070606@ti.com>
Message-ID: <201109091706.39621.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011, Santosh wrote:
> Sorry for such a basic question but I don't understand the need
> of these wrappers.
> I am not upto speed on this topic but what is the motivation
> behind the soc_smp_ops(). All of above functions are CPU specific
> and not really soc specific though, I agree that every SOC,
> implements it's own version.

We have two separate problems to solve that we should not confuse:

1. Get multiple soc platforms to compile together in a single kernel
   binary.
2. Share as much code as possible between similar soc platforms.

Marc's patch only addresses the first problem, and we need that
anyway if we want to get e.g. cortex-a9 based systems to be
supported in the same kernel as Qualcomm and Marvell CPU based
ones.

The other part is useful too, but it's easier to do after this one.

	Arnd
