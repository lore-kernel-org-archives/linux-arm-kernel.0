From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Aug 2018 10:41:30 +0100
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
Message-ID: <20180803094129.GB17798@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2018 at 09:16:39AM +0200, Ard Biesheuvel wrote:
> On 3 August 2018 at 08:35, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Thu, 2 Aug 2018, Matt Sealey wrote:
> >
> >> The easiest explanation for this would be that the memory isn?t mapped
> >> correctly. You can?t use PCIe memory spaces with anything other than
> >> Device-nGnRE or stricter mappings. That?s just differences between the
> >> AMBA and PCIe (posted/unposted) memory models.
> 
> Whoa hold on there.
> 
> Are you saying we cannot have PCIe BAR windows with memory semantics on ARM?
> 
> Most accelerated graphics drivers rely heavily on the ability to map
> the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
> ordinary memory.

Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
fine for prefetchable BARs, no?

Will
