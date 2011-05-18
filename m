From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 May 2011 22:47:41 +0100
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <20110518155615.GJ15292@game.jcrosoft.org>
References: <201105181047.17309.arnd@arndb.de>
	<20110518155615.GJ15292@game.jcrosoft.org>
Message-ID: <BANLkTi=LKYrhZkiAeLJH8VF4LkKnOr--zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, 18 May 2011, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 10:47 Wed 18 May ? ? , Arnd Bergmann wrote:
>> This is the draft plan for maintaining the ARM subarchitectures in a common
>> tree, as a way to help coordinate the upstream merging of the
>> arch/arm/{plat,mach}-* changes into Linus' tree.
>
> How do you plan to manage with already sub arch maintainers?
>
> In my ming such tree could be good to organise cross arch drivers
> but for real arch specific the current workflow is good
>
> If we add a new stage it will be difficult to follow for people
>
> I'd like to have scenario example where such workflow will give a significant
> advantage compare to the current workflow. And please real example.

I'll let Arnd and the other members of this group come up with real
examples. In the meantime I'll give my view on this.

The aim is not to hide existing sub-architecture patches behind
another git tree so that people won't notice the conflicts. It's not
just a workflow change, the Acked-by mechanism may have worked as
well, though some people may skip it (even unintentionally).

There is a lot of code duplication between various sub-architectures
under arch/arm/ and this group, together with the sub-arch
maintainers, will try to consolidate this, move common code out into
drivers/ so that it can be easily shared, start moving platforms to
FDT etc. (they could give a roadmap but it's early stages now). This
needs to be a coordinated effort and the group will ensure that the
general direction of code reduction is followed by all the current and
new sub-arch maintainers.

A lot of platform ports have been done just by copying existing code
without any effort in exploiting the commonality. This could be
spotted much easier with a dedicated group of people and guide the
sub-arch maintainers in the write direction. It may be even quicker
for them to get code merged into drivers/ where applicable.

I expect the activity of this group to be reduced in the future, once
the consolidation work is complete (but that's not a trivial task). At
that point maybe one or two people would just keep an eye on what gets
pushed into mainline in sub-arch directories and sub-arch maintainers
would just work as before, sending pull requests to Linus directly.

As the incentive for existing sub-arch maintainers to agree with this
strategy - given Linus' recent comments on the ARM sub-arch trees, it
is possible that he won't merge such trees pushed directly to him if
they don't show a consistent direction towards code consolidation. I
think this group and tree would actually make upstream pushing
quicker.

-- 
Catalin
