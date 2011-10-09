From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 09 Oct 2011 13:35:31 +0200
Subject: [PATCH 17/26] ARM: pxa: pxa95x is incompatible with earlier pxa
In-Reply-To: <CAN1soZyDu43EN3W5YBttdzx7qx=MLKAR1OsJC3hUdqWWxhQaew@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1499585.ED4ktnBDpX@wuerfel>
	<CAN1soZyDu43EN3W5YBttdzx7qx=MLKAR1OsJC3hUdqWWxhQaew@mail.gmail.com>
Message-ID: <5678343.s7jMIvu0rV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 October 2011 14:21:35 Haojian Zhuang wrote:
> > If we move it to arch/arm/Kconfig, I would prefer making it a global option,
> > not a pxa specific one. If we introduce a top-level CONFIG_CPU_V6PLUS
> > option, we can make a number of decisions inside of Kconfig depend on that,
> > especially as we move to allow building multiple v6/v7 platforms together,
> > or multiple v5 platforms for that matter. I believe we don't need to
> > worry about v5+v7 at this point and can instead assume that won't ever
> > happen.
> >
> Nobody is using PJ4 as v6 architecture now. CPUv6 is used in old stepping
> of Dove and MMP2. CPU_PJ4 only enables CPU_v7 in the mainline code.
> 
> If we used ARCH_PXA_V7 in arch/arm/Kconfig, we would have two ARCH for
> pxa. One is ARCH_PXA, and the other is ARCH_PXA_V7. Those v5 machine
> should be based on ARCH_PXA. And the saarb, tavorevb3 should be based
> on ARCH_PXA_V7. So we can avoid to define PXA_V7_MACH_AUTO. I think
> the logic of Kconfig could be easier.

I was referring to building different subarchitectures together.
We want to eventually be able to build a single kernel that
works on e.g. pxa95x (ARMv7) and omap2 (ARMv6), and we hope to get
there within the next few release. This is completely unrelated to
building a combination of old-world (ARMv3/v4/v5) and new-world
(ARMv6/v7) in a single kernel, which is something that we decided
not to try supporting in the forseeable future.

	Arnd
